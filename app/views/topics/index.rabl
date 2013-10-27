collection @topics
attributes :id, :title, :description
node(:post_count) { |topic| topic.posts.count }