class AddSlugToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :slug, :string
    add_index :groups, :slug, unique: true

    Group.find_each(&:save)
  end
end
