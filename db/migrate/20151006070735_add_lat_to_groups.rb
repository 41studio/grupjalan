class AddLatToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :lat, :string
  end
end
