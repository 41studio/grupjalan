class AddIndexToTable1 < ActiveRecord::Migration
  def change
    add_index :posts,  :trip_id
    add_index :posts,  :group_id
    add_index :groups, :trip_id
    add_index :groups, :user_id  
  end
end
