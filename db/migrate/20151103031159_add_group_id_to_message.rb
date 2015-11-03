class AddGroupIdToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :group_id, :integer
  end
end
