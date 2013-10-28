collection @topics
attributes :id, :title, :description
# 这里其实也可以用count方法，效果是一样的。这里用size方法，会在数据库层面执行COUNT(*)，因为在Post模型中设置了counter_cache: ture，所以
# 用这个的性能会好一点。
node(:postCount) { |topic| topic.posts.size }