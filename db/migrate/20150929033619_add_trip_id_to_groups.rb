class AddTripIdToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :trip_id, :integer
  end
end
