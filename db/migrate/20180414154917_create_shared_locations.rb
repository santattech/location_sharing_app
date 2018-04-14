class CreateSharedLocations < ActiveRecord::Migration
  def change
    create_table :shared_locations do |t|
      t.integer :user_id,  null: false
      t.integer :share_with_id, null: false
      t.integer :location_id, null: false
      t.timestamps null: false
    end

    add_foreign_key :shared_locations, :users
    add_foreign_key :shared_locations, :locations
    add_foreign_key :shared_locations, :users, column: :share_with_id
  end
end
