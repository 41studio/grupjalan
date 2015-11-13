class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.integer :country_id
      t.string :code
    end
    add_index :areas, :country_id
    add_index :areas, :code, unique: true
  end
end
