class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :topic_id
      t.integer :user_id
      t.text :content
      t.integer :like_count
      t.integer :reply_to_post_id

      t.timestamps
    end
  end
end
