class ThankingShip < ActiveRecord::Base
  belongs_to :user
  belongs_to :answer
end

# == Schema Information
#
# Table name: thanking_ships
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  answer_id  :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

