class MutedAskShip < ActiveRecord::Base
  belongs_to :ask
  belongs_to :user
end
