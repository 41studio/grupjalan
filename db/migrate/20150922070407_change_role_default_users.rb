class ChangeRoleDefaultUsers < ActiveRecord::Migration
  def change
  	change_column :users, :role, :string, :default => 0
  end
end
