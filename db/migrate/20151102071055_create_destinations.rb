class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.string :name

      t.timestamps null: false
    end
    add_index :destinations, :name, unique: true
  end
end
