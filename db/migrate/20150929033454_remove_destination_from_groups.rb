class RemoveDestinationFromGroups < ActiveRecord::Migration
  def change
    remove_column :groups, :destination, :string
  end
end
