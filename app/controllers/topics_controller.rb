# encoding: utf-8


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
  
  # POST topics
  def create
    @topic = Topic.new(params[:topic])
    if @topic.save
      render 'topics/show'
    else
      render json: @topic.errors.full_messages.to_json, status: 400
    end
  end
  
  # DELETE topics/:id
  def destroy
    Topic.find(params[:id]).destroy
    # @topic不可能删除不了，所以直接进行删除，不进行判断了。
    render json: '话题删除成功。'.to_json, status: 200
  end
  
end
