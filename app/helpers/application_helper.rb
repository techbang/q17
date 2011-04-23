module ApplicationHelper
  # form auth token
  def auth_token
    raw "<input name=\"authenticity_token\" type=\"hidden\" value=\"#{form_authenticity_token}\" />"
  end
  
end
