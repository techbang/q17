require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: tags
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  summary    :text
#  conver     :text
#  asks_count :integer(4)      default(0)
#  ask_id     :integer(4)
#  cover      :string(255)
#  string     :string(255)
#

