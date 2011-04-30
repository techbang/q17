class Followship < ActiveRecord::Base
  belongs_to :user 
  belongs_to :target , :polymorphic => true
  
  after_create :insert_create_time_entry
  
  #after_destroy :insert_delete_time_entry
  # TODO delete 有 bug 沒有 log
  # http://whilefalse.net/2011/04/05/rails-3-counter-cache-has_many-through/
  
  protected
  
  def insert_create_time_entry
    time_entry = self.user.time_entries.build
    time_entry.resource_type = "Followship"
    time_entry.resource_id = self.id
    time_entry.target_type = self.target_type
    time_entry.target_id = self.target_id
    time_entry.action = "ADD"
    time_entry.save!
  end

  
end
