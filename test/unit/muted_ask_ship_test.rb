require 'test_helper'

class MutedAskShipTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: ask_ships
#
#  id         :integer(4)      not null, primary key
#  ask_id     :integer(4)
#  user_id    :integer(4)
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

