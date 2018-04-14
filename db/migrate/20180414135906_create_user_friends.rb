class CreateUserFriends < ActiveRecord::Migration
  def change
    create_table :user_friends do |t|
      t.integer :user_id
      t.integer :friend_id

      t.timestamps null: false
    end

    add_foreign_key :user_friends, :users
    add_foreign_key :user_friends, :users, column: :friend_id
    add_index :user_friends, [:user_id, :friend_id], unique: true

    add_column :user_friends, :accepted_at, :datetime
  end
end
