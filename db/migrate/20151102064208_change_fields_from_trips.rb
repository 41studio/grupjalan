class ChangeFieldsFromTrips < ActiveRecord::Migration
  def change
    add_column :trips, :start_to_trip, :date
    add_column :trips, :end_to_trip, :date
    add_column :trips, :group_id, :integer

    remove_column :trips, :name_place

    add_index :trips, :group_id
  end
end
