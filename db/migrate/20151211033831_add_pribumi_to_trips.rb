class AddPribumiToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :pribumi, :boolean, default: false
  end
end
