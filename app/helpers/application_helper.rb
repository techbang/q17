module ApplicationHelper
  # form auth token
  def auth_token
    raw "<input name=\"authenticity_token\" type=\"hidden\" value=\"#{form_authenticity_token}\" />"
  end
  
  def owner?(item)
    return false if current_user.blank?
    user_id = nil
    if item.class == current_user.class
      user_id = item.id
    else
      user_id = item.user_id
    end
    if user_id == current_user.id
      return true
    end
    return false
  end
  
  
end
