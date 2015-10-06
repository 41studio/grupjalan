class AddFieldLatToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :lat, :integer
  end
end
