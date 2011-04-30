require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: answers
#
#  id               :integer(4)      not null, primary key
#  body             :text
#  comments_count   :integer(4)      default(0)
#  spams_count      :integer(4)      default(0)
#  spam_voter_ids   :integer(4)
#  up_votes_count   :integer(4)      default(0)
#  down_votes_count :integer(4)      default(0)
#  ask_id           :integer(4)
#  user_id          :integer(4)
#  created_at       :datetime
#  updated_at       :datetime
#

