class UsersController < ApplicationController
  # 响应xxxx.json的请求
  respond_to :json

  # POST /users
  def create
    # 这里这么写的好处是：只要客户端把对应的参数放在一个user的key下，后台这里就不需要再枚举一边key值了。
    @user = User.new(params[:user])
    if @user.save
      # app/views/users/create.rabl
      render "users/create"
    else
      # 直接返回，不通过模板，并且加上对应的status code。
      render json: {'failure_reason' => @user.errors.full_messages.first }.to_json, status: 400
    end
  end
end
