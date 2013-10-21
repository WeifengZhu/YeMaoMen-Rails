class UsersController < ApplicationController
  # 响应xxxx.json的请求
  respond_to :json

  # POST /users
  def create
    # 这里这么写的好处是：只要客户端把对应的参数放在一个user的key下，后台这里就不需要再枚举一边key值了。
    @user = User.new(params[:user])
    # 这里为什么用save，而不用save!，因为save如果成功返回true，如果失败会返回false，刚好放这。save!失败的话则会抛出异常
    # 不适用于这个if...else...end结构，应该用异常处理的那个结构。
    if @user.save
      # app/views/users/create.rabl
      render 'users/create'
    else
      # 直接返回json代码参考
      # render json: {'failure_reason' => @user.errors.full_messages.first }.to_json, status: 400
      #
      # 直接返回，不通过模板，并且加上对应的status code。
      render json: @user.errors.full_messages.to_json, status: 400
    end
  end
end
