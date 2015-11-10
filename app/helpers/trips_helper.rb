module TripsHelper
  #this path for helper group

  def link_for_members(is_members)
    if is_members
      link_to 'Members', members_group_path(@group), class: "btn btn-primary btn-md btn-block"
    else
      link_to "Posts", trip_group_path(@group), class: 'btn btn-primary btn-md btn-block'
    end
  end

  def link_for_join(is_included)
    if is_included
      link_to 'Leave Group', leave_group_path(@group), class: "btn btn-danger btn-md btn-block", method: :delete
    else
      link_to 'Join', join_group_path(@group), class: "btn btn-success btn-md btn-block", method: :post
    end
  end

  #this path for helper trip

  def link_for_members_trip(is_members)
    if is_members
      link_to 'Members', members_trip_trip_path(@trip), class: "btn btn-primary btn-md btn-block"
    end
  end

  def link_for_join_trip(is_included)
    if is_included
      link_to 'Leave trip', leave_trip_path(@trip), class: "btn btn-danger btn-md btn-block", method: :delete
    else
      link_to 'Join', join_trip_path(@trip), class: "btn btn-success btn-md btn-block", method: :post
    end
  end    
end