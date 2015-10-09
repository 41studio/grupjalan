class ChangeLngFormatInMyTable < ActiveRecord::Migration
  def up	
  	change_column :groups, :lng, :float
  end

  def down
    change_column :groups, :lng, :integer
  end	
end
