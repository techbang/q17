class AsksController < ApplicationController
  
  before_filter :require_user, :only => [:answer,:update_topic]
  before_filter :require_user_js, :only => [:answer,:invite_to_answer]
  before_filter :require_user_text, :only => [:update_topic,:redirect,:spam, :mute, :unmute, :follow, :unfollow]
  before_filter :find_ask, :only => [ :show , :redirect, :share, :spam, :spam, :edit, :update , :update_topic, :mute, :unmute, :follow, :unfollow ]
  
  
  def index
    @per_page = 20
    @asks = Ask.normal.recent.includes(:user).paginate(:page => params[:page], :per_page => @per_page)
    set_seo_meta("所有问题")
  end
  
  def create
    @ask = Ask.find_by_title(params[:ask][:title])
    if @ask
      flash[:notice] = "已有相同的问题存在，已重定向。"
      redirect_to ask_path(@ask.id)
      return 
    end
    @ask = Ask.new(params[:ask])
    @ask.user_id = current_user.id
    #TEMP_REMOVE
    #@ask.followers << current_user
    @ask.current_user_id = current_user.id

    respond_to do |format|
      if @ask.save
        format.html { redirect_to(ask_path(@ask.id), :notice => '问题创建成功。') }
        format.json
      else
        format.html { render :action => "new" }
        format.json
      end
    end
  end
  
  protected
  
  def find_ask
    @ask = Ask.find(params[:id])
  end
  
end
