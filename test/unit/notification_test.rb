require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: notifications
#
#  id         :integer(4)      not null, primary key
#  has_read   :boolean(1)
#  target_id  :integer(4)
#  action     :string(255)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

