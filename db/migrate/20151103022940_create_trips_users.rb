class CreateTripsUsers < ActiveRecord::Migration
  def change
    create_table :trips_users, id: false do |t|
      t.integer :trip_id
      t.integer :user_id
      
      t.timestamps null: false
    end
  end
end
