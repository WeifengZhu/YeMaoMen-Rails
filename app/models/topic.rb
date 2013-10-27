# == Schema Information
#
# Table name: topics
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  description :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Topic < ActiveRecord::Base
  
  attr_accessible :description, :title
  
  has_many :posts, dependent: :destroy 
  
  # 用于获取当天的话题。当天的话题数不固定，运营的时候每天创建了多少个话题，就会有多少个话题返回。
  def self.today
    where("created_at >= ?", Time.zone.now.beginning_of_day)
  end

end
