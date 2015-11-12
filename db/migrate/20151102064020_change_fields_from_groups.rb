class ChangeFieldsFromGroups < ActiveRecord::Migration
  def change
    remove_column :groups, :category_id
    remove_column :groups, :end_to_trip
    remove_column :groups, :start_to_trip
    remove_column :groups, :trip_id

    rename_column :groups, :group_name, :name
  end
end
