require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: users
#
#  id               :integer(4)      not null, primary key
#  login            :string(40)
#  name             :string(100)     default("")
#  nickname         :string(40)
#  slug             :string(40)
#  sex              :string(255)
#  email            :string(100)
#  fb_user_id       :integer(8)
#  email_hash       :string(255)
#  avatar_file_name :string(255)
#  role_id          :integer(4)
#  is_agreed        :boolean(1)
#  created_at       :datetime
#  updated_at       :datetime
#

