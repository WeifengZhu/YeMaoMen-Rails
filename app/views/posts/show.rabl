object @post

attributes :id, :content
attributes :topic_id => :topicID
attributes :like_count => :likeCount
attributes :updated_at => :updatedAt
# TODO 到时候根据UI来定到底要返回什么用户信息
# child(:user) { attributes :full_name } 
# TODO Post的盖楼效果，即类似网易新闻客户端里面回复能够盖楼一样。
child(:reply_to_post) { extends "posts/show" }
