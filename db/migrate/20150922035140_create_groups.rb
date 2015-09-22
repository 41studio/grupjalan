class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :group_name
      t.string :start_to_trip
      t.string :end_to_trip

      t.timestamps null: false
    end
  end
end
