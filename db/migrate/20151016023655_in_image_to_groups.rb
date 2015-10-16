class InImageToGroups < ActiveRecord::Migration
  def change
  	add_column :groups, :image, :string
  end
end
