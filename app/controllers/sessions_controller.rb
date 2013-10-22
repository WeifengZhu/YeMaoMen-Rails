# encoding: utf-8

class SessionsController < ApplicationController
  skip_before_filter :authorize

  # POST sessions
  def create
    # logger.debug "&&&&& the request header #{request.env.inspect}"
    @user = User.find_by_username(params[:username])

    if @user.nil?
      render json: '用户名不存在，请确认。'.to_json, status: 400
      return
    end

    # 这里可以用authenticate()是因为在User model中加入了has_secure_password这个函数调用。
    if @user && @user.authenticate(params[:password])
      render 'users/user'
    else
      render json: '密码不正确，请确认。'.to_json, status: 400
    end
  end
end
