class Comment < ActiveRecord::Base
  include BaseModel

  belongs_to :commentable, :polymorphic => true, :counter_cache => true
  belongs_to :user
  belongs_to :ask, :foreign_key => "commentable_id"
  belongs_to :answer, :foreign_key => "commentable_id"

  validates_presence_of :body
  
  after_create :insert_add_comment_time_entry
  
  protected
  
  def insert_add_comment_time_entry
    time_entry = self.user.time_entries.build
    time_entry.resource_type = "Comment"
    time_entry.resource_id = self.id
    time_entry.target_type = self.commentable_type
    time_entry.target_id = self.commentable_id
    time_entry.action = "ADD"
    time_entry.save!
  end
  

end

# == Schema Information
#
# Table name: comments
#
#  id               :integer(4)      not null, primary key
#  body             :text
#  commentable_type :string(255)
#  commentable_id   :integer(4)
#  user_id          :integer(4)
#  created_at       :datetime
#  updated_at       :datetime
#

