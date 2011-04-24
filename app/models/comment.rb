class Comment < ActiveRecord::Base
  include BaseModel
  
 # field :body
  
  belongs_to :commentable, :polymorphic => true, :counter_cache => true
  belongs_to :user
  has_many :logs, :class_name => "Log", :foreign_key => "target_id"
  belongs_to :ask, :foreign_key => "commentable_id"
  belongs_to :answer, :foreign_key => "commentable_id"

  validates_presence_of :body

  # 敏感词验证
  before_validation :check_spam_words
  before_create :fix_commentable_id
  
  def check_spam_words
    if self.spam?("body")
      return false
    end
  end
  
  def fix_commentable_id
    if self.commentable_id.class == "".class
      self.commentable_id = BSON::ObjectId(self.commentable_id)
    end
  end

  after_create :create_log
  
  protected
  
  def create_log
    
    log = user.logs.build
    
    log.type = "CommentLog"
    log.resource_id = self.id
    log.resource_type = "Comment"

    log.action = "NEW_#{self.commentable_type.upcase}_COMMENT"
    
    case self.commentable_type
    when "Answer"
      log.title = self.commentable.ask.title
    when "Ask"
      log.title = self.commentable.title
    end
    log.diff = ""
    log.save

  end

end
