class PagesController < ApplicationController
  def index
  end
  
  def update_in_place
    # TODO: Here need to chack permission
    klass, field, id = params[:id].split('__')
    puts params[:id]

    # 验证权限,用户是否有修改制定信息的权限
    case klass
    when "user" then return if current_user.id.to_s != id
    end
    
    params[:value] = simple_format(params[:value].to_s.strip) if params[:did_editor_content_formatted] == "no"

    object = klass.camelize.constantize.find(id)
    update_hash = {field => params[:value]}
    if ["ask","topic"].include?(klass) and current_user
      update_hash[:current_user_id] = current_user.id
    end
    if object.update_attributes(update_hash)
      render :text => object.send(field).to_s
    else
      Rails.logger.info "object.errors.full_messages: #{object.errors.full_messages}"
      render :text => object.errors.full_messages.join("\n"), :status => 422
    end
  end
  
  
  
  def followed
    @per_page = 20
    @asks = current_user ? current_user.followed_asks.normal : Ask.normal
    current_user_muted_ask_ids = current_user.muted_ask_ids
    @asks = @asks.includes(:user,:last_answer,:last_answer_user,:topics).exclude_ids(current_user_muted_ask_ids).order("answered_at, id DESC").paginate(:page => params[:page], :per_page => @per_page)

    if params[:format] == "js"
      render "/asks/index.js"
    else
      render "index"
    end
  end
  
  def recommended
    @per_page = 20
    @asks = current_user ? Ask.recommended_for_user(current_user) : Ask.normal
    @asks = @asks.includes(:user,:last_answer,:last_answer_user,:topics).exclude_ids(current_user.muted_ask_ids).order("answers_count,answered_at DESC").paginate(:page => params[:page], :per_page => @per_page)

    if params[:format] == "js"
      render "/asks/recommended.js"
    end
  end
  
end
