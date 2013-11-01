class PostsController < ApplicationController
  
  skip_before_filter :authorize, only: [:top_posts]
  
  # 响应xxxx.json的请求
  respond_to :json
  
  # GET top_posts
  def top_posts
    # 获取今天的Topic数组
    topics_of_today = Topic.today
    
    # 根据Topic和Post的association获取posts
    topics_of_today.each do |topic|
      
    end
    
    # 根据Post中定义的scope选出被赞数前三的post，并且不是回复别人的猫聊
    
    # 组成top_posts数组，RABL模板根据这个数组返回json数据。
  end
  
end
