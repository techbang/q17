class UsersController < ApplicationController
  
  before_filter :init_user, :except => [:auth_callback]
  
  def init_user
    @user = User.find_by_nickname(params[:id])
    if @user.blank? or !@user.deleted.blank?
      render_404
    end
    @ask_to_user = Ask.new
  end
  
  def answered
    @per_page = 10
    @asks = Ask.normal.recent.find(@user.answered_ask_ids).paginate(:page => params[:page], :per_page => @per_page)
    set_seo_meta("#{@user.name}回答过的问题")
    if params[:format] == "js"
      render "/users/answered_asks.js"
    end
  end
  
  def asked_to
    @per_page = 10
    @asks = Ask.normal.recent.asked_to(@user.id).paginate(:page => params[:page], :per_page => @per_page)
    set_seo_meta("问#{@user.name}的问题")
    if params[:format] == "js"
      render "/asks/index.js"
    else
      render "asked"
    end
  end
  
  
  def show
    @per_page = 10
    
    @logs = current_user.time_entries.order("id DESC").paginate(:page => params[:page], :per_page => @per_page)
    
   # @logs = Log.order("id DESC").where(:user_id => @user.id).paginate(:page => params[:page], :per_page => @per_page)
    
    if params[:format] == "js"
      render "/logs/index.js"
    end
  end
  
  def asked
    @per_page = 10
    @asks = @user.asks.normal.recent.paginate(:page => params[:page], :per_page => @per_page)
    set_seo_meta("#{@user.name}问过的问题")
    if params[:format] == "js"
      render "/asks/index.js"
    end
  end
  
  def following_topics
    @per_page = 20
    @topics = @user.followed_topics.order("id DESC").paginate(:page => params[:page], :per_page => @per_page)
    
    set_seo_meta("#{@user.name}关注的话题")
    if params[:format] == "js"
      render "following_topics.js"
    end
  end
  
  def followers
    @per_page = 20
    @followers = @user.followers.order("id DESC").paginate(:page => params[:page], :per_page => @per_page)
    
    set_seo_meta("关注#{@user.name}的人")
    if params[:format] == "js"
      render "followers.js"
    end
  end
  
  def following
    @per_page = 20
    @followers = @user.following.order("id DESC").paginate(:page => params[:page], :per_page => @per_page)
    
    set_seo_meta("#{@user.name}关注的人")
    if params[:format] == "js"
      render "followers.js"
    else
      render "followers"
    end
  end
  
  def follow
    if not @user
      render :text => "0"
      return
    end
    current_user.follow(@user)
    render :text => "1"
  end
  
  def unfollow
    if not @user
      render :text => "0"
      return
    end
    current_user.unfollow(@user)
    render :text => "1"
  end
end
