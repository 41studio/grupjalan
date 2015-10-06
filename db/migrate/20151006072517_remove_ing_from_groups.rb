class RemoveIngFromGroups < ActiveRecord::Migration
  def change
    remove_column :groups, :ing, :string
  end
end
