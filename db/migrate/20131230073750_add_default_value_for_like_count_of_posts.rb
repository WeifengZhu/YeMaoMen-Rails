class AddDefaultValueForLikeCountOfPosts < ActiveRecord::Migration
  def up
    change_column :posts, :like_count, :integer, default: 0
  end

  def down
    change_column :posts, :like_count, :integer, default: nil
  end
end
