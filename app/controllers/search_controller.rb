class SearchController < ApplicationController

  def all
    result = Search.query(params[:q].strip,:limit => 10)
    lines = []
    result.each do |item|
      case item['type']
      when "Ask"
        lines << complete_line_ask(item)
      when "User"
        lines << complete_line_user(item)
      when "Topic"
        lines << complete_line_topic(item)
      end
    end
    render :text => lines.join("\n")
  end

  def users
    result = User.text_search(params[:q])

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

  private
    def complete_line_ask(item,hash = true)
      if hash
        "#{item['title']}#!##{item['id']}#!##{item['topics'].join(',')}#!#Ask"
      else
        "#{item.title.gsub("\n",'')}#!##{item.id}#!##{item.topics.join(',')}#!#Ask"
      end
    end

    def complete_line_topic(item,hash = true)
      if hash
        "#{item['title']}#!##{item['followers_count']}#!##{item['cover_small']}#!#Topic"
      else
        "#{item.name}#!##{item.followers_count}#!##{item.cover_small}#!#Topic"
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
