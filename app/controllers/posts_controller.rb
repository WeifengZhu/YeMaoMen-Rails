# encoding: utf-8

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
  
  # POST posts
  def create
    @post = Post.new(params[:post])
    if @post.save
      render json: '猫聊发布成功。'.to_json, status: 200
    else
      render json: @post.errors.full_messages.to_json, status: 400
    end
  end
  
  # DELETE posts/:id
  def destroy
    @post = Post.find(params[:id])
    
    # 如果这个猫聊由于某种原因不能被删除的话。可以用过一个callback(before_destroy)来判断猫聊是否能被删除,
    # 如果before_destroy这个callback返回false的话，那么@post.destroy也返回false，然后就可以把为什么不能删除用户的原因返回
    # 给API了。
    if @post.destroy
      render json: '猫聊删除成功。'.to_json, status: 200
    else
      render json: '由于XXX，猫聊删除未能成功。'.to_json, status: 400
    end
  end
  
end
