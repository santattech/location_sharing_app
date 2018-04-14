class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :latitude, null: false
      t.string :longitude, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end

    add_foreign_key :locations, :users
  end
end
