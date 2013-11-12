# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 创建用户
(1..10).each do |i|
  User.create(username: "user#{i}", password: '000000', password_confirmation: '000000', score: i)
end

# 常见闲扯猫聊
(1..40).each do |i|
  Post.create(user_id: 1, content: 'The content of the post.', like_count: i )
end

# 创建话题
(1..5).each do |i|
  Topic.create(title: "topic#{i}", description: "description#{i}")
end

# 创建话题下猫聊
(1..40).each do |i|
  Post.create(user_id: 2, topic_id: 1, content: 'The content of the post.', like_count: i, )
end

