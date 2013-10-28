# == Schema Information
#
# Table name: posts
#
#  id               :integer         not null, primary key
#  topic_id         :integer
#  user_id          :integer
#  content          :text
#  like_count       :integer
#  reply_to_post_id :integer
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

class Post < ActiveRecord::Base
  
  attr_accessible :content, :like_count, :reply_to_post_id, :topic_id, :user_id
  
  # A belongs_to association sets up a one-to-one connection with another model, such that each instance of the declaring 
  # model “belongs to” one instance of the other model. 在posts表中要有topic_id这个字段。
  belongs_to :topic
  belongs_to :user
  
  # self join
  # 这么设置好之后，可以通过@post.reply_to_post来获取这个post所回复的post。
  has_one :reply_to_post, class_name: "Post", foreign_key: "reply_to_post_id"
    
end
