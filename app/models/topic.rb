class Topic < ActsAsTaggableOn::Tag

  include Redis::TextSearch
   
  attr_accessor :current_user_id, :cover_changed, :followers_count_changed
  attr_accessible :name, :summary, :current_user_id, :cover, :cover_file_name
  
  has_attached_file :cover, 
    :path => ":rails_root/public/system/:class/:id/:style/:filename",
    :url => "/system/:class/:id/:style/:filename",
    :default_url => "/images/missing.png",
    :styles => { :normal => "100x100>"}


  #field :asks_count, :type => Integer, :default => 0
  
  # Followers
  
  has_many :followed_topic_ships, :as => :target , :class_name => "Followship"
  has_many :followers, :through => :followed_topic_ships, :source => :user
  

  validates_presence_of :name
  validates_uniqueness_of :name, :case_insensitive => true

  # 以下两个方法是给 redis search index 用
  
  text_index :name
  text_index :summary
  
  after_save do |topic|
    topic.update_text_indexes
  end
  
  def to_param
    "#{name}"
  end
  
  def followers_count
    self.follower_ids.count
  end

  def followers_count_changed?
    self.followers_count_changed
  end

  def cover_small
    self.cover.small.url
  end

  def cover_small_changed?
    self.cover_changed?
  end

  before_update :insert_update_topic_time_entry
  
  def self.find_by_name(name)
    #TODO : #4423
    #find(:first,:conditions => {:name => /^#{name.downcase}$/i})
    find(:first,:conditions => ["name LIKE ?", name.downcase] )
  end

  def self.search_name(name, options = {})
    limit = options[:limit] || 10
    where(:name => /#{name}/i ).desc(:asks_count).limit(limit)
  end

  protected
  
    
    def insert_update_topic_time_entry
      user = User.find(self.current_user_id)
      time_entry = user.time_entries.build
      time_entry.resource_type = "Topic"
      time_entry.resource_id = self.id
      
      if self.summary_changed? 
        time_entry.action = "EDIT_SUMMARY"
        time_entry.save!
      end
      
      #time_entry.action = "EDIT"
    
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

