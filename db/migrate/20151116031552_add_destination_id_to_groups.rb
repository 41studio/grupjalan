class AddDestinationIdToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :destination_id, :integer
    add_index :groups, :destination_id
  end
end
