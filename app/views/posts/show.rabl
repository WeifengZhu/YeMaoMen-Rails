object @post

attributes :id, :content
attributes :topic_id => :topicID
attributes :like_count => :likeCount
attributes :updated_at => :updatedAt
# TODO 到时候根据UI来定到底要返回什么用户信息
# child(:user) { attributes :full_name } 

# root_object实际上就是@post，但在这个template里面，只能用root_object来指代@post，而不能直接使用@post，否则无法找到reply_to_post这个
# association会找不到。
# 这个if表达式的意思，就是看是否这个post是回复别人的post，如果是，则在这个post里面包含被回复的那个post。
# 这个是个递归的过程。
if root_object.reply_to_post
  child(:reply_to_post => :parentPost) { extends "posts/show" }  
end



