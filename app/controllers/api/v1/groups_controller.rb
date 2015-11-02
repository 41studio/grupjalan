class Api::V1::GroupsController < BaseApiController

  def_param_group :search_group do
    param :start_to_trip, String, "Start to trip for group, format: 'dd/mm/yyyy'"
    param :end_to_trip, String, "End to trip for group, format: 'dd/mm/yyyy'"
    param :trip_name, String, "Trip name or location trip"
  end

  api :POST, "/v1/groups/search"
  param_group :search_group
  def search
    @groups = Group.select(:id, :group_name, :start_to_trip, :end_to_trip, :location, :photo, :trip_id).joins(:trip).where(
      "LOWER(trips.name_place) = :trip_name AND start_to_trip <= :end_to_trip AND end_to_trip >= :start_to_trip",
      {
        start_to_trip: params[:start_to_trip].to_date,
        end_to_trip: params[:end_to_trip].to_date,
        trip_name: params[:trip_name].downcase
      }
    )
  end

  api :GET, "v1/groups/:id"
  param :id, String, "Group id"
  def show
    @group = Group.includes(posts: [:user, comments: [:user]]).find(params[:id])
  end
end