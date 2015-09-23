class AddDestinationToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :destination, :string
  end
end
