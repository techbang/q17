class User < Techbang::User
  include Techbang::UserProfileMethods
  include Redis::TextSearch
  acts_as_voter
  
  attr_accessible :login, :name, :nickname, :email, :fb_user_id, :email_hash , :avatar_file_name , :profile_attributes
  has_many :notifications


  has_many :following_user_ships, :class_name => "Followship"
  has_many :following_users, :through => :following_user_ships, :source => :target , :source_type => "User", :before_remove => :insert_unfollow_user_time_entry
  
  has_many :befollow_user_ships, :as => :target , :class_name => "Followship"
  has_many :followers, :through => :befollow_user_ships, :source => :user


  has_many :followed_ask_ships, :class_name => "Followship"
  has_many :followed_asks , :through => :followed_ask_ships, :source => :target , :source_type => "Ask" , :before_remove => :insert_unfollow_ask_time_entry

  has_many :followed_topic_ships, :class_name => "Followship"
  has_many :followed_topics , :through => :followed_topic_ships, :source => :target , :source_type => "Topic" , :before_remove => :insert_unfollow_topic_time_entry

  has_many :answered_ask_ships
  has_many :answered_asks, :through => :answered_ask_ships, :source => :ask

  has_many :muted_ask_ships
  has_many :muted_asks, :through => :muted_ask_ships, :source => :ask
  
  has_many :thanking_ships
  has_many :thanking_answers, :through => :thanking_ships, :source => :answer

  has_many :answers
  has_many :logs
  has_many :time_entries, :foreign_key => "creator_id"
  
  after_save do |user|
    user.delay.update_search_indexes if user.nickname_changed?
  end

  text_index :nickname

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

  def suggest_items
    return UserSuggestItem.gets(self.id, :limit => 6)
  end

  def topic_followed?(topic)
    self.followed_topics.include?(topic)
  end

  def mute_ask(ask)
    self.muted_asks << ask
  end

  def unmute_ask(ask)
    self.muted_asks.delete(ask)
  end

  def follow(user)
    self.following_users << user
  end
  
  def unfollow(user)
    self.following_users.delete(user)
  end
  
  def follow_ask(ask)
    ask.followers << self
  end

  def unfollow_ask(ask)
    self.followed_asks.delete(ask)
  end

  def follow_topic(topic)
    topic.followers << self
    # TODO 清除推荐话题
    #UserSuggestItem.delete(self.id, "Topic", topic.id)
  end

  def unfollow_topic(topic)
    self.followed_topics.delete(topic)
  end
  
  def thank_answer(answer)
    self.thanking_answers << answer
    #insert_follow_log("THANK_ANSWER", answer, answer.ask)
  end

  protected

  private
  
    # 該死的 before_destroy 不起作用只好用這種方式解
    
    def insert_unfollow_user_time_entry(record)
      time_entry = self.time_entries.build
      ship = Followship.find_by_user_id_and_target_type_and_target_id(self,  "Techbang::User" , record.id)
      time_entry.resource_type = "Followship"
      time_entry.resource_id = ship.id
      time_entry.target_type = "User"
      time_entry.target_id = record.id
      time_entry.action = "DELETE"
      time_entry.save!
    end
  
    def insert_unfollow_ask_time_entry(record)
      time_entry = self.time_entries.build
      ship = Followship.find_by_user_id_and_target_type_and_target_id(self,  "Ask" , record.id)
      time_entry.resource_type = "Followship"
      time_entry.resource_id = ship.id
      time_entry.target_type = "Ask"
      time_entry.target_id = record.id
      time_entry.action = "DELETE"
      time_entry.save!
    end

    def insert_unfollow_topic_time_entry(record)
      time_entry = self.time_entries.build
      ship = Followship.find_by_user_id_and_target_type_and_target_id(self,  "ActsAsTaggableOn::Tag" , record.id)
      time_entry.resource_type = "Followship"
      time_entry.resource_id = ship.id
      time_entry.target_type = "Topic"
      time_entry.target_id = record.id
      time_entry.action = "DELETE"
      time_entry.save!
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
#  asks_count       :integer(4)      default(0)
#  answers_count    :integer(4)      default(0)
#  tagline          :string(255)
#

