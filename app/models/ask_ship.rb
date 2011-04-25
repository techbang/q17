class AskShip < ActiveRecord::Base
  belongs_to :ask
  belongs_to :user
end
