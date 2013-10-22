class ApplicationController < ActionController::Base
  protect_from_forgery

  # 子类能够用到的方法，要放在protected下，不能放在private下。
  protected
    def authorize
      unless User.find_by_identify_token(session[:user_id])
        render json: '未登录，请先登录。'.to_json, status: 401
      end
    end
end
