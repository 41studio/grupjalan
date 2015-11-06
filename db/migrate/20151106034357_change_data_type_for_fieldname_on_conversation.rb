class ChangeDataTypeForFieldnameOnConversation < ActiveRecord::Migration
  def self.up
    change_table :conversations do |t|
      t.change :members, :string
    end
  end
  def self.down
    change_table :conversations do |t|
      t.change :members, :integer
    end
  end
end
