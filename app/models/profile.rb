class Profile < ActiveRecord::Base
  GENDER = { "男" => "m", "女" => "f" }
  EDUCATION = ['國中以下', '高中高職', '大專大學', '碩士', '博士']
  INCOME = ['30萬以下', '30-50萬', '50-80萬', '80-100萬', '100-200萬', '200萬以上']
  JOB = ['資訊科技業', '製造業', '金融貿易業', '傳播廣告業', '服務業', '自營商', '自由業', '軍公教', '學生']
  PREFERRED_INFO = ['科技', '網路', '手機', '攝影', '遊戲', '比價']
  AGE = {'9 歲以下' => 1, '10-14' => 2, '15-19' => 3, '20-24' => 4, '25-29' => 5, '30-34' => 6, '35-39' => 7, '40-44' => 8, '45-49' => 9, '50-54' => 10, '55-59' => 11, '60 歲以上' => 12}
  DOMAIN_HEAD   = '(?:[A-Z0-9\-]+\.)+'.freeze
  DOMAIN_TLD    = '(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|jobs|museum)'.freeze

  belongs_to :user

  serialize :preferred_info

  validates_format_of :name, :with => Techbang::Regex::NAME, :allow_nil => true, :allow_blank => true, :message => Techbang::Regex::NAME_MESSAGE
  validates_length_of :name, :maximum => 100, :allow_nil => true, :allow_blank => true
  validates_format_of :gender, :with => /^[mf]?$/, :message => "應為男性或女性", :allow_nil => true, :allow_blank => true
  # validates_format_of :age, :with => /^\d*$/, :message => "應為正整數"
  validates_length_of :resume, :maximum => 100, :allow_nil => true, :allow_blank => true
  validates_format_of :mobile, :with => /^[\d]+$/, :allow_nil => true, :allow_blank => true
  validates_length_of :mobile, :is => 10, :allow_nil => true, :allow_blank => true
  validates_format_of :phone, :with => /^[\d]+$/, :allow_nil => true, :allow_blank => true
  validates_length_of :phone, :within => 8..10, :allow_nil => true, :allow_blank => true

  before_save :setup_real_age

  def gender_display
    GENDER.values.include?(gender) ? GENDER.index(gender) : "未知"
  end

  def age_display
    AGE.index(age_interval)
  end

  def real_age_display
    age.present? ? age : "未知"
  end

  def preferred_info_display
    return "未知" if preferred_info.blank?
    preferred_info.delete_if { |i| i.blank? }.join(', ')
  end

  def age_interval
    count = age.to_i / 5
    count = 1 if count < 1
    count = 12 if count > 12
    count
  end

  def real_age
    return unless birthday
    Time.now.utc.year - birthday.year
  end

  protected

  def setup_real_age
    self.age = real_age
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

