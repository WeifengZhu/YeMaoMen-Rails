class PostsController < ApplicationController
  
  skip_before_filter :authorize, only: [:top_posts]
  
  # 响应xxxx.json的请求
  respond_to :json
  
  # GET top_posts
  def top_posts
    # 获取今天的Topic ActiveRecord::Relation集合
    
    # TODO 为了测试用Topic.all，实际使用的时候应该用Topic.today。  
    # topics_of_today = Topic.today
    topics_of_today = Topic.all
    
    # 初始化@posts
    @posts = Array.new
    
    # 根据Topic和Post的association获取top posts
    # original和top_three都是定义在Post中的scope
    topics_of_today.each do |topic|
      top_posts_of_topic = topic.posts.original.top_three
      # Rails.logger.debug { "each top_posts_of_topic: #{top_posts_of_topic.inspect}" }
      @posts = @posts + top_posts_of_topic
    end
    
    # Rails.logger.debug { "the result @posts: #{@posts}" }
    render 'posts/top_posts'
  end
  
end
