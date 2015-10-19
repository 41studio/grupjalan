class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :plan_category

      t.timestamps null: false
    end
  end
end
