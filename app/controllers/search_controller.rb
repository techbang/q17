class SearchController < ApplicationController
  def users 
    keyword = params[:q]
    result_ids = User.isearch("nickname:#{keyword}", :len => 1000, :fetch => 'user_id')
    result = User.find(result_ids)
    
    if params[:format] == "json"
      render :json => result.to_json
    else
      lines = []
      result.each do |item|
        lines << complete_line_user(item)
      end
      render :text => lines.join("\n") 
    end
  end
  
  def complete_line_user(item,hash = true)
    if hash
      "#{item['title']}#!##{item['id']}#!##{item['tagline']}#!##{item['avatar_small']}#!##{item['slug']}#!#User"
    else
      # TODO
      # "#{item.name}#!##{item.id}#!##{item.tagline}#!##{item.avatar_small}#!##{item.slug}#!#User"
      "#{item.nickname}#!##{item.id}#!##{item.id}#!##{item.id}#!##{item.id}#!#User"
    end
  end
  
end
