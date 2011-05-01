class AnswersController < ApplicationController
  before_filter :require_user_text
  before_filter :find_answer
  
  def vote
    vote_type = :down
    if params[:inc] == "1"
      vote_type = :up
    end
    if vote_type == :down
      success = current_user.vote_against(@answer)
    else
      success = current_user.vote_for(@answer)
    end
    
    if params[:inc] == "1"
      begin
        log = UserLog.new
        log.user_id = current_user.id
        log.target_id = @answer.id
        log.action = "AGREE"
        log.target_parent_id = @answer.ask.id
        log.target_parent_title = @answer.ask.title
        log.diff = ""
        log.save
      rescue Exception => e
      
      end
    end
    
    @answer.reload
    render :text => "#{@answer.votes_for}|#{@answer.votes_against}"
  end
  
  def spam
    size = 1
    if(Setting.admin_emails.include?(current_user.email))
      size = Setting.answer_spam_max
    end
    count = @answer.spam(current_user.id,size)
    render :text => count
  end
  
  protected

   def find_answer
     @answer = Answer.find(params[:id])
   end
   
end
