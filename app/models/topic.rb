class Topic < ActsAsTaggableOn::Tag
  include BaseModel
  
  attr_accessor :current_user_id, :cover_changed, :followers_count_changed
  attr_accessible :name, :summary, :current_user_id
  #field :cover

  #field :asks_count, :type => Integer, :default => 0

  has_many :logs, :class_name => "Log", :foreign_key => "target_id"
  
  # Followers
  
  has_many :followed_topic_ships, :as => :target , :class_name => "Followship"
  has_many :followers, :through => :followed_topic_ships, :source => :user
  

  validates_presence_of :name
  validates_uniqueness_of :name, :case_insensitive => true

  # 以下两个方法是给 redis search index 用
  
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

  # FullText indexes
  #search_index(:fields => [:name],
  #             :attributes => [:name,:cover_small, :followers_count],
  #             :attribute_types => {:cover_small => String, :followers_count => Integer},
  #             :options => {} )

  #redis_search_index(:title_field => :name,
  #                   :ext_fields => [:followers_count,:cover_small])

  # Hack 上传图片，用于记录 cover 是否改变过
  def cover=(obj)
    super(obj)
    self.cover_changed = true
  end

  before_update :insert_update_topic_time_entry
  
  def update_log
   # return  if self.current_user_id.blank?
   #insert_update_topic_time_entry if self.summary_changed?
   # insert_action_log("EDIT") #if self.cover_changed or self.summary_changed?
  end

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

