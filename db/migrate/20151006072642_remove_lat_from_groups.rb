class RemoveLatFromGroups < ActiveRecord::Migration
  def change
    remove_column :groups, :lat, :string
  end
end
