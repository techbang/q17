require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: profiles
#
#  id             :integer(4)      not null, primary key
#  user_id        :integer(4)
#  name           :string(100)     default("")
#  gender         :string(255)
#  birthday       :date
#  age            :string(255)
#  hobby          :string(255)
#  skill          :string(255)
#  education      :string(255)
#  job            :string(255)
#  income         :string(255)
#  preferred_info :string(255)
#  blog_url       :string(255)
#  facebook_url   :string(255)
#  plurk_url      :string(255)
#  twitter_url    :string(255)
#  resume         :string(255)
#  mobile         :string(255)
#  phone          :string(255)
#  zip_code       :string(255)
#  city           :string(255)
#  county         :string(255)
#  address        :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

