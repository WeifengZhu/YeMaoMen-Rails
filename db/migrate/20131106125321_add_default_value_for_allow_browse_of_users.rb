class AddDefaultValueForAllowBrowseOfUsers < ActiveRecord::Migration
  def up
    change_column :users, :allow_browse, :boolean, default: true
  end

  def down
    change_column :users, :allow_browse, :boolean, default: nil
  end
end
