class AnswersController < ApplicationController
  before_filter :require_user_text
  before_filter :find_answer
  
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
