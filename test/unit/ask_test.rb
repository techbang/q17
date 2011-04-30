require 'test_helper'

class AskTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: asks
#
#  id                  :integer(4)      not null, primary key
#  title               :string(255)
#  body                :text
#  answered_at         :datetime
#  answers_count       :integer(4)      default(0)
#  comments_count      :integer(4)      default(0)
#  topic               :string(255)
#  spams_count         :integer(4)      default(0)
#  spam_voter_ids      :string(255)
#  views_count         :integer(4)      default(0)
#  last_updated_at     :datetime
#  redirect_ask_id     :integer(4)
#  user_id             :integer(4)
#  last_answer_user_id :integer(4)
#  last_answer_id      :integer(4)
#  created_at          :datetime
#  updated_at          :datetime
#

