class AsksController < ApplicationController
  def index
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
  
end
