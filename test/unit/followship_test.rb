require 'test_helper'

class FollowshipTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: followships
#
#  id          :integer(4)      not null, primary key
#  target_id   :integer(4)
#  target_type :string(255)
#  user_id     :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

