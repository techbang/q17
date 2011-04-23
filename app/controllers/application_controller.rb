class ApplicationController < ActionController::Base
  protect_from_forgery
  include Facebooker2::Rails::Controller
  include Techbang::Authentication::System
  
  use_zomet
end
