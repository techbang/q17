require 'test_helper'

class ReportSpamTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: report_spams
#
#  id          :integer(4)      not null, primary key
#  url         :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

