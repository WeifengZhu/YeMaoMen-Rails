class AddIdentifyTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :identify_token, :string
    add_index :users, :identify_token
  end
end
