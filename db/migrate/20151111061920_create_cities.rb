class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.integer :area_id
      t.string :code
    end
    
    add_index :cities, :area_id
    add_index :cities, :code, unique: true
  end
end
