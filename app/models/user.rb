class User < ActiveRecord::Base
  include Techbang::UserProfileMethods
  include Techbang::UserConfirmation
  
  attr_accessible :login, :name, :nickname, :email, :fb_user_id, :email_hash , :avatar_file_name , :profile_attributes
  
end
