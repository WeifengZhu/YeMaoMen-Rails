# == Schema Information
#
# Table name: users
#
#  id               :integer         not null, primary key
#  username         :string(255)
#  password_digest  :string(255)
#  bio              :string(255)
#  location         :string(255)
#  avatar_url       :string(255)
#  allow_browse     :boolean
#  score            :integer
#  last_active_time :datetime
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

class User < ActiveRecord::Base
  attr_accessible :allow_browse, :avatar_url, :bio, :last_active_time, :location, :password_digest, :score, :username

  # call create_remember_token before save
  before_save :create_identify_token

  pirvate:

    # 目前的处理逻辑是用户被保存进数据库之前产生一个identify_token并保存进数据库，用户登陆并不会刷新这个token，所以不能保证用户只能登陆
    # 一台设备，后续如果有需要可以加上这个限制。
    def create_identify_token
      # without self the assignment would create a local variable called identify_token, 
      # which isn’t what we want at all.
      self.identify_token = SecureRandom.urlsafe_base64
    end
end
