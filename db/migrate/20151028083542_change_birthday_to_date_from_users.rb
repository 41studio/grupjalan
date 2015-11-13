class ChangeBirthdayToDateFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :brithday

    add_column :users, :birthday, :date
  end

  def down
    remove_column :users, :birthday

    add_column :users, :brithday, :string
  end
end
