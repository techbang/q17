# coding: utf-8
class Search
  attr_accessor :type, :title, :id, :exts
  def initialize(options = {})
    self.exts = []
    options.keys.each do |k|
      eval("self.#{k} = options[k]")
    end
  end
  
  def self.query(text,options = {})
    return [] if text.strip.blank?

    #words = Ask.mmseg_text(text)
    words = text
    limit = options[:limit] || 10
    type = options[:type] || nil

    result = []
    if type.blank?
      result << Topic.text_search(words, :limit => limit)
      result << User.text_search(words, :limit => limit)
      result << Ask.text_search(words, :limit => limit)
    end  
    
    result = result.flatten
    return result

  end

end
