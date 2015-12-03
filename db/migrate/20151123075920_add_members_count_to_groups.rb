class AddMembersCountToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :members_count, :integer

    Group.all.each do |group|
      group.update(members_count: group.trips.count)
    end
  end

  def down
    remove_column :groups, :members_count
  end
end
