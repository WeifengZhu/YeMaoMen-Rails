# encoding: utf-8

class PostsController < ApplicationController
  
  skip_before_filter :authorize, only: [:top_posts, :index, :posts_by_like_count]
  
  # GET posts
  def index
    # before_timestamp, after_timestamp, page_size, topic_id, target_user_id都是定义在application_controller.rb中的方法。
    # 这些方法可以在这个controller的其他方法中，或其他controller中得到复用。
    hash = { before_timestamp: before_timestamp, after_timestamp: after_timestamp, page_size: page_size, 
      order_by_like_count: false }
    # render_posts()是PostsController定义的一个private方法。
    render_posts(hash)  
  end
  
  # GET posts_by_like_count
  def posts_by_like_count
    hash = { before_timestamp: before_timestamp, after_timestamp: after_timestamp, page_size: page_size, 
      order_by_like_count: true }
    render_posts(hash)
  end
  
  # GET my_posts
  def my_posts
    @posts = @user.posts
    render 'posts/index'
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
  
  # PUT posts/:id
  # like猫聊。因为没有更新猫聊这个功能（只有删除猫聊的功能）所以update这个action刚好可以用来承载like猫聊的功能。
  def update
    @post = Post.find(params[:id])
    @post.like_count += 1
    # 暂时不对user能否save成功作判断。
    @post.user.score += 1
    @post.user.save
    if @post.save
      render json: '成功赞'.to_json, status: 200
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
  
  private
  
    def render_posts(hash)
      if !topic_id.nil? && target_user_id.nil?
        # 话题空间的猫聊列表
        @posts = Topic.find(topic_id).posts.limited_posts(hash)
      elsif topic_id.nil? && target_user_id.nil?
        # 闲扯板块的猫聊
        @posts = Post.free_chat.limited_posts(hash)
      elsif topic_id.nil? && !target_user_id.nil?
        # 查看别人的猫聊历史
        target_user = User.find(target_user_id)
        # nil和false都是false
        if target_user.allow_browse
          @posts = target_user.posts.limited_posts(hash)
        else
          if hash[:order_by_like_count]
            @posts = target_user.posts.order("like_count DESC").limit(5)
          else
            @posts = target_user.posts.order("updated_at DESC").limit(5)
          end
        end
      else
        # !topic_id.nil? && !target_user_id.nil? 理论上，如果客户端请求正确的话，不会出现这种情况。
      end
      render 'posts/index'
    end
  
end
