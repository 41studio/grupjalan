class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :members

      t.timestamps null: false
    end
    add_index :conversations, :members
  end
end
