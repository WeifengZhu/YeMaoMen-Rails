class UsersController < ApplicationController
  # 响应xxxx.json的请求
  respond_to :json

  def create
    # 这里这么写的好处是：只要客户端把对应的参数放在一个user的key下，后台这里就不需要再枚举一边key值了。
    @user = User.new(params[:user])
    @user.save
    # 为毛不用指定返回啥？
    # because Rails will automatically detect and render the associated view once the template is defined. 
  end
end
