class Ask < ActiveRecord::Base

 include BaseModel
   
  # 提问人
  belongs_to :user, :counter_cache => true
  # 对指定人的提问
  belongs_to :to_user, :class_name => "User"

  # 回答
  has_many :answers
  # Log
  has_many :logs, :class_name => "Log", :foreign_key => "target_id"
  # 最后个回答
  belongs_to :last_answer, :class_name => 'Answer'
  # 最后回答者
  belongs_to :last_answer_user, :class_name => 'User'
  # Followers
   
  has_many :followed_ask_ships, :as => :target , :class_name => "Followship"
  has_many :followers, :through => :followed_ask_ships, :source => :user
  
  #has_many :topics
  acts_as_taggable_on :topics
  
  # Comments
  has_many :comments, :conditions => {:commentable_type => "Ask"}, :foreign_key => "commentable_id", :class_name => "Comment"

  has_many :ask_invites
  
  has_many :time_entries
  after_create :insert_add_ask_time_entry
  before_update :insert_update_ask_time_entry
  

  attr_protected :user_id
  attr_accessor :current_user_id
  validates_presence_of :user_id, :title
  validates_presence_of :current_user_id, :if => proc { |obj| obj.title_changed? or obj.body_changed? }

  # 正常可显示的问题, 前台调用都带上这个过滤
  
  scope :normal, where( "spams_count <= ? ", Setting.ask_spam_max)
  scope :last_actived, :order => "answered_at DESC" 
  scope :recent, :order => "created_at DESC"
  
  # 除开一些 id，如用到 mute 的问题，传入用户的 muted_ask_ids
  scope :exclude_ids, lambda { |ids|
    where(['id NOT IN (?)', ids]) if ids.any?
  }
  scope :only_ids, lambda { |ids|
    where(['id IN (?)', ids]) if ids.any?
  }

  # 问我的问题
  scope :asked_to, lambda { |to_user_id| where(:to_user_id => to_user_id) }

  #TEMP_REMOVE
  ## FullText indexes
  #search_index(:fields => [:title,:topics],
  #             :attributes => [:title,:topics],
  #             :options => {} )

  #redis_search_index(:title_field => :title,:ext_fields => [:topics])

  before_save :fill_default_values
  #after_create :create_log
  after_create :send_mails


  def view!
    self.class.increment_counter(:views_count, 1)
  end

  def send_mails
    # 向某人提问
    if !self.to_user.blank?
      if self.to_user.mail_ask_me
        UserMailer.ask_user(self.id).deliver
      end
    end
  end

  def update_log
    insert_action_log("EDIT") if self.title_changed? or self.body_changed?
  end

  def create_log
    insert_action_log("NEW")
  end

  def chomp_body
    if self.body == "<br>"
      return ""
    else
      chomped = self.body
      while chomped =~ /<div><br><\/div>$/i
        chomped = chomped.gsub(/<div><br><\/div>$/i, "")
      end
      return chomped
    end
  end

  def fill_default_values
    # 默认回复时间为当前时间，已便于排序
    if self.answered_at.blank?
      self.answered_at = Time.now
    end
  end

  # 更新话题
  # 参数 topics 可以是数组或者字符串
  # 参数 add  true 增加, false 去掉
  def update_topics(topic_name, add = true, current_user_id = nil)  
    # asks/update_topic 會判斷是新增還是減少
    if add
      self.topic_list << topic_name
      action = "ADD"
    else
      self.topic_list.remove(topic_name)
      action = "DELETE"
    end

    self.save
    topic = Topic.find_by_name(topic_name)
    self.send("insert_#{action.downcase}_topic_time_entry", topic)
  end

  # 提交问题为 spam
  def spam(voter_id,size = 1)
    self.spams_count ||= 0
    self.spam_voter_ids ||= []
    # 限制 spam ,一人一次
    return self.spams_count if self.spam_voter_ids.index(voter_id)
    self.spams_count += size
    self.spam_voter_ids << voter_id
    self.current_user_id = "NULL"
    self.save()
    return self.spams_count
  end

  def self.mmseg_text(text)
    result = Ask.search(text,:max_matches => 1)
    words = []
    result.raw_result[:words].each do |w|
      t = w[0].dup.force_encoding("utf-8")
      next if t == "ask"
      words << ((t == "rubi" and text.downcase.index("ruby")) ? "ruby" : t )
    end
    # 修正顺序
    words = words.sort { |x,y| (text.index(x) || -1) <=> (text.index(y) || -1) }
    Rails.logger.debug { "mmseg:#{words}" }
    words
  end

  def self.search_title(text,options = {})
    limit = options[:limit] || 10
    Ask.search(text,:limit => limit)
  end

  def self.find_by_title(title)
    first(:conditions => {:title => title})
  end

  # 重定向问题
  def redirect_to_ask(to_id)
    # 不能重定向自己
    return -2 if to_id.to_s == self.id.to_s
    @to_ask = Ask.find(to_id)
    # 如果重定向目标的是重定向目前这个问题的，就跳过，防止无限重定向
    return -1 if @to_ask.redirect_ask_id.to_s == self.id.to_s
    self.redirect_ask_id = to_id
    self.save
    1
  end

  # 取消重定向
  def redirect_cancel
    self.redirect_ask_id = nil
    self.save
  end
  
  
  def self.recommended_for_user(current_user)
    #Ask.normal.any_of({:topics.in => current_user.followed_topics.map{|t| t.name}}).not_in(:follower_ids => [current_user.id]).and(:answers_count.lt => 1) 
    # TODO #4421
    
    Ask.normal
  end

  protected
  
    def insert_add_ask_time_entry
      time_entry = self.user.time_entries.build
      time_entry.resource_type = "Ask"
      time_entry.resource_id = self.id
      time_entry.action = "ADD"
      time_entry.save!
    end
    
    def insert_update_ask_time_entry
      time_entry = self.user.time_entries.build
      time_entry.resource_type = "Ask"
      time_entry.resource_id = self.id
      
      if self.title_changed? 
        time_entry.action = "EDIT_TITLE"
        time_entry.save!
      elsif self.body_changed? 
        time_entry.action = "EDIT_BODY"
        time_entry.save!
      end
      #time_entry.action = "EDIT"
    
    end
    
    def insert_action_log(action)
      # begin


         #TODO : "NEW_TO_USER", "ADD_TOPIC", "DEL_TOPIC"

         #log.target_attr = (self.title_changed? ? "TITLE" : (self.body_changed? ? "BODY" : "")) if action == "EDIT"
         #if(action == "NEW" and !self.to_user_id.blank?)
         #  action = "NEW_TO_USER"
         #  log.target_parent_id = self.to_user_id
         #end

         log.action = action
         log.diff = ""
         log.save
       #rescue Exception => e

       #end
     end
    
    def insert_add_topic_time_entry(topic)
      time_entry = self.user.time_entries.build
      time_entry.resource_type = "Ask"
      time_entry.resource_id = self.id
      time_entry.target_type = "Topic"
      time_entry.target_id = topic.id
      time_entry.action = "ADD"
      time_entry.save!
    end
    
    def insert_delete_topic_time_entry(topic)
      time_entry = self.user.time_entries.build
      time_entry.resource_type = "Ask"
      time_entry.resource_id = self.id
      time_entry.target_type = "Topic"
      time_entry.target_id = topic.id
      time_entry.action = "DELETE"
      time_entry.save!
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

