class UsersController < ApplicationController
  
  before_filter :init_user, :except => [:auth_callback]
  
  def init_user
    @user = User.find_by_nickname(params[:id])
    if @user.blank? or !@user.deleted.blank?
      render_404
    end
    @ask_to_user = Ask.new
  end
  
  def show
    @per_page = 10
    
    @logs = TimeEntry.order("id DESC").paginate(:page => params[:page], :per_page => @per_page)
    
   # @logs = Log.desc("$natural").where(:user_id => @user.id).paginate(:page => params[:page], :per_page => @per_page)
    
    if params[:format] == "js"
      render "/logs/index.js"
    end
  end
end
