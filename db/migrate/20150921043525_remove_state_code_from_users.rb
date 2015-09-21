class RemoveStateCodeFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :state_code, :string
  end
end
