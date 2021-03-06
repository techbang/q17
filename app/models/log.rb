class Log < ActiveRecord::Base
  belongs_to :user
  belongs_to :resource, :polymorphic => true
  attr_protected :user_id
end

class AskLog < Log
  after_save :send_notification
  
  def send_notification
    case self.action
    when "INVITE_TO_ANSWER"
    #  Notification.create(user_id: self.target_parent_id,log_id: self.id,target_id: self.target_id,action: "INVITE_TO_ANSWER")
    when "NEW_TO_USER"
     # Notification.create(user_id: self.target_parent_id,log_id: self.id,target_id: self.target_id,action: "ASK_USER")
    end
  end
end

class TopicLog < Log
end

class UserLog < Log

  after_save :send_notification
  
  def send_notification
    case self.action
    when "FOLLOW_USER"
   #   Notification.create(user_id: self.target_id, log_id: self.id, target_id: self.target_id,  action: "FOLLOW")
    when "AGREE"
      answer = Answer.find(self.target_id)
    #  Notification.create(user_id: answer.user_id, log_id: self.id, target_id: self.target_parent_id, action: "AGREE_ANSWER") if answer
    when "THANK_ANSWER"
      answer = Answer.find(self.target_id)
    #  Notification.create(user_id: answer.user_id, log_id: self.id, target_id: self.target_id, action: self.action)
    end
  end
end

class AnswerLog < Log
  belongs_to :ask

  after_save :send_notification
  
  def send_notification
    case self.action
    when "NEW"
     # Notification.create(user_id: self.answer.ask.user_id,  log_id: self.id, target_id: self.target_parent_id, action: "NEW_ANSWER") if self.answer and self.answer.ask and self.answer.user_id != self.answer.ask.user_id
    end
  end
end

class CommentLog < Log
  
  after_save :send_notification
  
  def send_notification
    case self.action
    when "NEW_ASK_COMMENT"
      #Notification.create(user_id: self.comment.ask.user_id,  log_id: self.id, target_id: self.target_parent_id, action: self.action) if self.comment and self.comment.ask and self.comment.ask.user_id != self.comment.user_id
    when "NEW_ANSWER_COMMENT"
      #Notification.create(user_id: self.comment.answer.user_id, log_id: self.id, target_id: self.target_parent_id,  action: self.action) if self.comment and self.comment.answer and self.comment.answer.ask and self.comment.answer.user_id != self.comment.user_id
    end
  end
end

# == Schema Information
#
# Table name: logs
#
#  id                  :integer(4)      not null, primary key
#  title               :string(255)
#  target_attr         :string(255)
#  action              :string(255)
#  diff                :text
#  target_id           :integer(4)
#  target_parent_title :string(255)
#  user_id             :integer(4)
#  type                :string(255)
#  resource_type       :string(255)
#  resource_id         :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#

