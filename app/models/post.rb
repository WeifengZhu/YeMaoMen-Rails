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
  # 这么设置好之后，可以通过@post.reply_to_post来获取这个post所回复的post，通过@post.re_posts来获取回复这个Post的posts。
  # 如果有，则返回这个post对象，如果没有，则返回nil。可以用以下表达式来判断关联对象是否存在：@post.reply_to_post.nil?,
  # @post.re_posts.empty?（如果不存在对应的关联对象的话，那么@post.re_posts返回空的array）。
  # @post.reply_to_post默认是会用缓存的，即：
  # If the associated object has already been retrieved from the database for this object, the cached version will be returned. 
  # To override this behavior (and force a database read), pass true as the force_reload argument(@post.reply_to_post(true)).
  #
  # If you set the :dependent option to :nullify, then deleting this object will set the foreign key in the association object to NULL.
  has_many :re_posts, :class_name => "Post", foreign_key: "reply_to_post_id", dependent: :nullify
  belongs_to :reply_to_post, :class_name => "Post"
    
end
