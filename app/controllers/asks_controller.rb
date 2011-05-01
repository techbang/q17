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
  
  def new
    @ask = Ask.new
    respond_to do |format|
      format.html # new.html.erb
      format.json
    end
  end
  
  def edit
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
  
  def show
    @ask.view!

    if @ask.redirect_ask_id.present?
      if params[:nr].blank?
        # 转向问题
        redirect_to ask_path(@ask.redirect_ask_id,:rf => params[:id], :nr => "1")
        return
      else
        @r_ask = Ask.find(@ask.redirect_ask_id)
      end
    end

    if params[:rf]
      @rf_ask = Ask.find(params[:rf])
      if @ask.redirect_ask_id.present?
        @r_ask = Ask.find(@ask.redirect_ask_id)
      end
    end
    
    # 由于 voteable_mongoid 目前的按 votes_point 排序有问题，没投过票的无法排序
    
    @answers = @ask.answers.includes(:user).order("up_votes_count DESC,down_votes_count ASC,created_at ASC")
    #@answers = @ask.answers.includes(:user).order_by(:"votes.uc".desc,:"votes.dc".asc,:"created_at".asc)
    @answer = Answer.new
    # TEMP_REMOVE
    # @relation_asks = Ask.normal.any_in(:topics => @ask.topics).excludes(:id => @ask.id).limit(10).desc("$natural")
    @relation_asks = Ask.all
    # 被邀请回答的用户
    # TEMP_REMOVE
    #@invites = @ask.ask_invites.includes(:user)
    @invites = @ask.ask_invites
    set_seo_meta(@ask.title)

    respond_to do |format|
      format.html # show.html.erb
      format.json
    end
  end
  
  def answer
    @answer = Answer.new(params[:answer])
    @answer.ask_id = params[:id]
    @answer.user_id = current_user.id
    
    @answer.body = simple_format(@answer.body.strip) if params[:did_editor_content_formatted] == "no"
    
    if @answer.save
      @success = true
    else
      @success = false
    end

  end
  
  
  def spam 
    size = 1
    if(Setting.admin_emails.include?(current_user.email))
      size = Setting.ask_spam_max
    end
    count = @ask.spam(current_user.id,size)
    render :text => count
  end
  
  def update_topic
    @name = params[:name].strip
    @add = params[:add] == "1" ? true : false
    if @ask.update_topics(@name,@add,current_user.id)
      @success = true
    else
      @success = false
    end
    if not @add
      render :text => @success
    end
  end
  
  
  def mute
    if !@ask
      render :text => "0"
      return
    end
    current_user.mute_ask(@ask)
    render :text => "1"
  end
  
  def unmute
    if !@ask
      render :text => "0"
      return
    end
    current_user.unmute_ask(@ask)
    render :text => "1"
  end
  
  def follow
    if !@ask
      render :text => "0"
      return
    end
    current_user.follow_ask(@ask)
    render :text => "1"
  end

  def unfollow
    if !@ask
      render :text => "0"
      return
    end
    current_user.unfollow_ask(@ask)
    render :text => "1"
  end
  
  def share
    if request.get?
      if current_user
        render "share", :layout => false
      else
        render_404
      end
    else
      case params[:type]
      when "email"
        UserMailer.simple(params[:to], params[:subject], params[:body].gsub("\n","<br />")).deliver
        @success = true
        @msg = "已经将问题连接发送到了 #{params[:to]}"
      end
    end

  end
  
  def invite_to_answer
    drop = params[:drop] == "1" ? true : false
    if drop
      result = AskInvite.cancel(params[:i_id], current_user.id)
      render :text => "1"
    else
      if (current_user.id.to_s != params[:user_id].to_s)
        @invite = AskInvite.invite(params[:id], params[:user_id], current_user.id)
        @success = true
      else
        @success = false
      end
    end
  end

  
  protected
  
  def find_ask
    @ask = Ask.find(params[:id])
  end
  
end
