class AddIndexToTable < ActiveRecord::Migration
  def change
    add_index :trips, :user_id
    add_index :posts, :user_id
    add_index :messages, :group_id
    # add_index :groups, :category_id  
  end
end
