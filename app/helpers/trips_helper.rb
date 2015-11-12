module TripsHelper
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
end
