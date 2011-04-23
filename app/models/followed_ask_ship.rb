class FollowedAskShip < ActiveRecord::Base
  belongs_to :user
  belongs_to :ask
end
