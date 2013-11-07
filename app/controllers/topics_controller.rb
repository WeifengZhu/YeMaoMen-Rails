class TopicsController < ApplicationController
  
  skip_before_filter :authorize, only: [:index]
  
  # GET topics
  def index
    # today()方法是我在Topic这个model种定义的class方法，用于获取当天的话题。
    # today只判断created_at时间是否属于今天，而不判断数量。
    @topics = Topic.today
    # views/topics/index.rabl
    render 'topics/index'  
  end
  
end
