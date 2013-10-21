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
#  identify_token   :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :allow_browse, :avatar_url, :bio, :location, :password, :password_confirmation, 
  :score, :username, :last_active_time

  # 写了这个就表明：表单提交的参数中要有password和password_confirmation，并且两者要一致。
  # 到时候user对象中存的是根据password和password_confirmation计算出来的password_digest。
  has_secure_password

  # call create_remember_token before save
  before_save :create_identify_token

  validates :username, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :password, presence: true
  validates :password_confirmation, presence: true

  private

    # 目前的处理逻辑是用户被保存进数据库之前产生一个identify_token并保存进数据库，用户登陆并不会刷新这个token，所以不能保证用户只能登陆
    # 一台设备，后续如果有需要可以加上这个限制。
    def create_identify_token
      # without self the assignment would create a local variable called identify_token, 
      # which isn’t what we want at all.
      self.identify_token = SecureRandom.urlsafe_base64
    end
end
