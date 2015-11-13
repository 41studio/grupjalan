class CreateTripsUsers < ActiveRecord::Migration
  def change
    create_table :trips_users do |t|
      t.integer :trip_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :trips_users, :trip_id
    add_index :trips_users, :user_id
  end
end
