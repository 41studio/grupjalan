class AddPhotoToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :photo, :string
  end
end
