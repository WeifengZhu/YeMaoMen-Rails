class AddIndexToUsersUsername < ActiveRecord::Migration
  def change
    # 两个好处：1）保证find_by_username的效率。2）在数据库层面保证数据唯一性。如果仅仅在model文件中加入unique: true的话，
    # 访问量大的情况下，还是有可能建如重复数据的。
    add_index :users, :username, unique: true
  end
end
