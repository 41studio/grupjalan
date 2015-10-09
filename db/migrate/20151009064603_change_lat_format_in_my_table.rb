class ChangeLatFormatInMyTable < ActiveRecord::Migration
  def up	
  	change_column :groups, :lat, :float
  end

  def down
    change_column :groups, :lat, :integer
  end	
end
