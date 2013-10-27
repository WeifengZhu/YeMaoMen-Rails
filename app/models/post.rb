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
  
  belongs_to :topic
  belongs_to :user
    
end
