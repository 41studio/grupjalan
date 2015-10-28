class ChangeStartToTripAndEndToTripToDateFromGroups < ActiveRecord::Migration
  def change
    remove_column :groups, :start_to_trip
    remove_column :groups, :end_to_trip

    add_column :groups, :start_to_trip, :date
    add_column :groups, :end_to_trip, :date
  end

  def down
    remove_column :groups, :start_to_trip
    remove_column :groups, :end_to_trip

    add_column :groups, :start_to_trip, :string
    add_column :groups, :end_to_trip, :string
  end
end
