# encoding: utf-8

class UsersController < ApplicationController

  skip_before_filter :authorize, only: [:create]

  # 响应xxxx.json的请求
  respond_to :json

  # POST users
  def create
    # 这里这么写的好处是：只要客户端把对应的参数放在一个user的key下，后台这里就不需要再枚举一边key值了。
    @user = User.new(params[:user])
    # 这里为什么用save，而不用save!，因为save如果成功返回true，如果失败会返回false，刚好放这。save!失败的话则会抛出异常
    # 不适用于这个if...else...end结构，应该用异常处理的那个结构。
    if @user.save
      # app/views/users/user.rabl
      render 'users/user'
    else
      # 直接返回json代码参考
      # render json: {'failure_reason' => @user.errors.full_messages.first }.to_json, status: 400
      #
      # 直接返回，不通过模板，并且加上对应的status code。
      render json: @user.errors.full_messages.to_json, status: 400
    end
  end

  # POST users/info
  def update
    # @user已经被authorize这个before_filter方法找到了
    if @user.update_attributes(params[:user])
      render 'users/user'
    else
      render json: @user.errors.full_messages.to_json, status: 400
    end
  end

  # DELETE users
  def destroy
    # @user已经被authorize这个before_filter方法找到了
    #
    # 如果这个用户由于某种原因（例：其下有未读私信）不能被删除的话。可以用过一个callback(before_destroy)来判断用户是否能被删除,
    # 如果before_destroy这个callback返回false的话，那么@user.destroy也返回false，然后就可以把为什么不能删除用户的原因返回
    # 给API了。
    if @user.destroy
      render json: '夜猫账户删除成功。'.to_json, status: 200
    else
      render json: '由于XXX，夜猫账户删除未能成功。'.to_json, status: 400
    end
  end

end
