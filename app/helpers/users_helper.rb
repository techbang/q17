# coding: utf-8
module UsersHelper
  def user_name_tag(user, options = {})
    options[:url] ||= false
    return "" if user.blank?
    #return "匿名用户" if !user.deleted.blank?
    return user.name if user.slug.blank?
    url = options[:url] == true ? user_url(user.slug) : user_path(user.slug)
    raw "<a#{options[:is_notify] == true ? " onclick=\"mark_notifies_as_read(this, '#{options[:notify].id}');\"" : ""} href=\"#{url}\" class=\"user\" title=\"#{user.name}\">#{user.name}</a>"
  end
end
