class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :bio
      t.string :location
      t.string :avatar_url
      t.boolean :allow_browse
      t.integer :score
      t.datetime :last_active_time

      t.timestamps
    end
  end
end
