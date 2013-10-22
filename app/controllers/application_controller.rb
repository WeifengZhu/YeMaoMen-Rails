# encoding: utf-8

class ApplicationController < ActionController::Base
  # 白名单，所有controller的方法默认都需要被filter，其他controller里面如果不需要被filter的话，加上：
  # skip_before_filter :authorize, only: [:create, :update, :destroy] # create, update和destroy三个不需要被filter。
  before_filter :authorize

  protect_from_forgery

  # 子类能够用到的方法，要放在protected下，不能放在private下。
  protected
    # 被authorize filter过的方法，都已经有@user这个成员变量了。如果filter失败，已经返回了，不会去到相应的方法了。
    def authorize
      @user = User.find_by_identify_token(request.env["HTTP_IDENTIFYTOKEN"])
      unless @user
        render json: '未登录，请先登录。'.to_json, status: 401
      end
    end
end
