class TopicsController < ApplicationController
  def show
    name = params[:id].strip
    @per_page = 10
    @topic = Topic.find_by_name(name)
    if @topic.blank?
      return render_404
    end
    
    # TODO #4422
    #@asks = Ask.all_in(:topics => [/#{name}/i]).normal.recent.paginate(:page => params[:page], :per_page => @per_page)
    topic_ids = Topic.find(:all,:conditions => ["name LIKE ?", name.downcase] ).collect(&:id)
    @asks = Ask.only_ids(topic_ids).normal.recent.paginate(:page => params[:page], :per_page => @per_page)
    
    set_seo_meta(@topic.name,:description => @topic.summary)

    if !params[:page].blank?
      render "/asks/index.js"
    end
  end
  
  
end