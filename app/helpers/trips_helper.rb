# == Schema Information
#
# Table name: trips
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#  slug           :string
#  start_to_trip  :date
#  end_to_trip    :date
#  group_id       :integer
#  member_size    :integer          default(0)
#  destination_id :integer
#  pribumi        :boolean          default(FALSE)
#
# Indexes
#
#  index_trips_on_destination_id  (destination_id)
#  index_trips_on_group_id        (group_id)
#  index_trips_on_member_size     (member_size)
#  index_trips_on_slug            (slug) UNIQUE
#  index_trips_on_user_id         (user_id)
#

module TripsHelper
  #this path for helper group

  def link_for_members(is_members)
    if is_members
      link_to 'Members', members_group_trip_path(@group, @trip), class: "btn btn-primary btn-md btn-block"
    else
      link_to "Posts", group_trip_path(@group, @trip), class: 'btn btn-primary btn-md btn-block'
    end
  end

  def link_for_join(is_included)
    if is_included
      link_to 'Leave Group', leave_group_path(@group), class: "btn btn-danger btn-md btn-block", method: :delete
    else
      link_to 'Join Group', join_group_path(@group), class: "btn btn-success btn-md btn-block", method: :post
    end
  end

  def link_for_join_trip(is_included, trip)
    if is_included
      link_to 'Leave Trip', leave_group_trip_path(@group, trip), class: "btn btn-danger btn-md btn-block", method: :delete
    else
      link_to 'Join Trip', join_group_trip_path(@group, trip), class: "btn btn-success btn-md btn-block", method: :post
    end
  end

  #this path for helper trip

  def link_for_members_trip(is_members)
    if is_members
      link_to 'Members', members_group_trip_path(@trip), class: "btn btn-primary btn-md btn-block"
    end
  end

  def link_for_join_trip(is_included)
    if is_included
      link_to 'Leave trip', leave_group_trip_path(@trip), class: "btn btn-danger btn-md btn-block", method: :delete
    else
      link_to 'Join', join_group_trip_path(@trip), class: "btn btn-success btn-md btn-block", method: :post
    end
  end    
end






