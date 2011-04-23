class User < ActiveRecord::Base
  include Techbang::UserProfileMethods

  attr_accessible :login, :name, :nickname, :email, :fb_user_id, :email_hash , :avatar_file_name , :profile_attributes
  has_many :notifications
  
  has_many :followed_ask_ships
  has_many :followed_asks, :through => :followed_ask_ships, :source => :ask
  
  def ask_followed?(ask)
    # Rails.logger.info { "user: #{self.inspect}" }
    # Rails.logger.info { "asks: #{self.followed_asks.inspect}" }
    # Rails.logger.info { "ask: #{ask.inspect}" }
    self.followed_asks.include?(ask)
  end
  
  # 不感兴趣问题
  def ask_muted?(ask_id)
    self.muted_ask_ids.include?(ask_id)
  end
  
  def mute_ask(ask_id)
     self.muted_ask_ids ||= []
     return if self.muted_ask_ids.index(ask_id)
     self.muted_ask_ids << ask_id
     self.save
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

