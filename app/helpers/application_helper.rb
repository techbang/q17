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
  
  def render_item_link(item)
    case item.class.to_s
      when "Topic", "ActsAsTaggableOn::Tag"
        link_to("#"+item.name, topic_path(item.name))
      when "Ask"
        link_to(item.title, ask_path(item))
      when "User", "Techbang::User"
        link_to(item.nickname, user_path(item.nickname))
      when "Answer"
        link_to(item.ask.title, ask_path(item.ask))
      end
  end
  
end
