module AsksHelper
  def ask_title_tag(ask, options = {})
    class_name = options[:class] || ""
    prefix = ""
    if !ask.to_user.blank?
      prefix = "#{ask.to_user.name}："
    end
    raw "<a href=\"/asks/#{ask.id}\" class=\"#{class_name}\">#{prefix}#{ask.title}</a>"
  end
  
  def md_body(str)
    return "" if str.blank?
    # str = simple_format(str) if str =~ /\n/
    # Rails.logger.info "str: #{str.inspect}"
    str = sanitize(str,:tags => %w(strong b i u strike s ol ul li blockquote address br div p), :attributes => %w(src))
    str = auto_link_urls(str,{:target => "_blank", :rel => "nofollow" }, {:limit => 80 })
    return raw str
  end
  
  # 检测是否 Spam 过 Ask 
  def spamed?(ask)
    return false if current_user.blank? or ask.spam_voter_ids.blank?
    return ask.spam_voter_ids.count(current_user.id) > 0
  end
  
end
