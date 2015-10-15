class RemoveImageFromGroups < ActiveRecord::Migration
  def change
    remove_column :groups, :image, :string
  end
end
