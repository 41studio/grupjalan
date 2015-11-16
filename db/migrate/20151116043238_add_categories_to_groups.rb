class AddCategoriesToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :categories, :text, array: true, default: []
  end
end
