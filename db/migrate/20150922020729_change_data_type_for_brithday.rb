class ChangeDataTypeForBrithday < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.change :brithday, :string
    end
  end
  def self.down
    change_table :users do |t|
      t.change :brithday, :date
    end
  end
end
