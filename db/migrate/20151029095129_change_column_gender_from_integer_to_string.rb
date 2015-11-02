class ChangeColumnGenderFromIntegerToString < ActiveRecord::Migration
  def change
    change_column :users, :gender, :string, default: 'male'
  end

  def down
    change_column :users, :gender, :integer
  end
end
