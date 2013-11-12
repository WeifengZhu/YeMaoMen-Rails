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
  
  # This association indicates that each instance of the model has zero or more instances of another model.
  # The name of the other model is pluralized when declaring a has_many association.
  has_many :posts, dependent: :destroy
  
  validates :title, presence: true
  validates :description, presence: true
  
  # 用于获取当天的话题。当天的话题数不固定，运营的时候每天创建了多少个话题，就会有多少个话题返回。
  def self.today
    # 注意这里对时区的处理。zone(), now()可以查API文档。
    where("created_at >= ?", Time.zone.now.beginning_of_day).order("created_at DESC")
  end

end
