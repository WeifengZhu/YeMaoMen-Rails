collection @topics
attributes :id, :title, :description
node(:postCount) { |topic| topic.posts.size }