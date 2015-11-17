class AddDestinationIdToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :destination_id, :integer
    add_index :trips, :destination_id
  end

  def down
    remove_column :trips, :destination_id
  end
end
