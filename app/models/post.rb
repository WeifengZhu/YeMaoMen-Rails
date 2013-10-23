class Post < ActiveRecord::Base
  attr_accessible :content, :like_count, :reply_to_post_id, :topic_id, :user_id
end
