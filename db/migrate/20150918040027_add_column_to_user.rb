class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :neighborhood, :string
    add_column :users, :address, :text
    add_column :users, :gender, :integer
    add_column :users, :brithday, :date
    add_column :users, :handphone, :string
    add_column :users, :status, :string
    add_column :users, :role, :integer
  end
end
