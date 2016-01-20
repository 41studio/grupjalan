class AddStartToTripEndToTripToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :start_to_trip, :date
    add_column :posts, :end_to_trip, :date
  end
end
