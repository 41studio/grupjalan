class AddFieldLngToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :lng, :integer
  end
end
