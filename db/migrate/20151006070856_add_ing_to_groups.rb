class AddIngToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :ing, :string
  end
end
