# encoding: utf-8

class PostsController < ApplicationController
  
  skip_before_filter :authorize, only: [:top_posts]
  
  # 响应xxxx.json的请求
  respond_to :json
  
  # GET posts
  def index
    topic_id = params[:topic_id]
    target_user_id = params[:target_user_id]
    if topic_id.nil? && target_user_id == @user.id
      # 我的猫聊列表
      @posts = @user.posts
    elsif !topic_id.nil? && target_user_id.nil?
      # 话题空间的猫聊列表
      @posts = Topic.find(topic_id).posts
    elsif topic_id.nil? && target_user_id.nil?
      # 闲扯板块的猫聊
      @posts = Post.free_chat
    elsif topic_id.nil? && !target_user_id.nil? && target_user_id != @user.id
      # 查看别人的猫聊历史
      target_user = User.find(target_user_id)
      if target_user.allow_browse
        @posts = target_user.posts
      else
        @posts = target_user.posts.limit(5)
      end
    else
      # !topic_id.nil? && !target_user_id.nil? 理论上，如果客户端请求正确的话，不会出现这种情况。
    end
  end
  
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
    render 'posts/index'
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
  
  # DELETE posts
  # 删除当前用户下的所有猫聊。
  def destroy_all
    @user.posts.each do |post|
      post.destroy
    end
    render json: '所有猫聊删除成功。'.to_json, status: 200
  end
  
end
