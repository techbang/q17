class TimeEntry < ActiveRecord::Base
  belongs_to :resource , :polymorphic => true
  belongs_to :target   , :polymorphic => true
  belongs_to :creator, :class_name => "User"
  after_create :insert_to_user_timelog
  
  protected

  def insert_to_user_timelog
    case resource_type
    when "Comment"

    when "Topic"

    end
  end
end


# == Schema Information
#
# Table name: time_entries
#
#  id            :integer(4)      not null, primary key
#  creator_id    :integer(4)
#  resource_type :string(255)
#  resource_id   :integer(4)
#  target_type   :string(255)
#  target_id     :integer(4)
#  type          :string(255)
#  action        :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

