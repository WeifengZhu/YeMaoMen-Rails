class AddIndexToTopicsCreatedAt < ActiveRecord::Migration
  
  def change
    # 为什么需要这个index？
    # 话题是以天为分割的，所以，每一天获取话题的action都会以created_at作为一个condition。加这个索引有利于性能。
    add_index :topics, :created_at
  end
  
end
