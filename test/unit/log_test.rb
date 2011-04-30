require 'test_helper'

class LogTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: logs
#
#  id                  :integer(4)      not null, primary key
#  title               :string(255)
#  target_attr         :string(255)
#  action              :string(255)
#  diff                :text
#  target_id           :integer(4)
#  target_parent_title :string(255)
#  user_id             :integer(4)
#  type                :string(255)
#  resource_type       :string(255)
#  resource_id         :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#

