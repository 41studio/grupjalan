class AddMemberSizeToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :member_size, :integer, default: 0
    add_index :trips, :member_size
  end
end
