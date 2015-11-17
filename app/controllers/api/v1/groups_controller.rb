class Api::V1::GroupsController < BaseApiController

  def_param_group :search_group do
    param :start_to_trip, String, "Start to trip for group, format: 'dd/mm/yyyy'"
    param :end_to_trip, String, "End to trip for group, format: 'dd/mm/yyyy'"
    param :name, String, "Group name"
  end

  api :GET, "/v1/groups/search"
  param_group :search_group
  def search
    @groups = Group.joins(:trips).where(
      "LOWER(groups.name) ILIKE :name AND trips.start_to_trip = :start_to_trip AND trips.end_to_trip >= :end_to_trip", 
      {
        start_to_trip: params[:start_to_trip].to_date,
        end_to_trip: params[:end_to_trip].to_date,
        name: "%#{params[:name].downcase}%"
      }
    )
  end

  api :GET, "v1/groups/:id"
  param :id, String, "Group id"
  def show
    @group = Group.includes(posts: [:user, comments: [:user]]).find(params[:id])
  end
end