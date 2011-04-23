module AsksHelper
  def ask_title_tag(ask, options = {})
    class_name = options[:class] || ""
    prefix = ""
    if !ask.to_user.blank?
      prefix = "#{ask.to_user.name}："
    end
    raw "<a href=\"/asks/#{ask.id}\" class=\"#{class_name}\">#{prefix}#{ask.title}</a>"
  end
  
end
