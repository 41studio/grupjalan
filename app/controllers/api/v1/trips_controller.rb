class Api::V1::TripsController < BaseApiController

  api :GET, "/v1/trips"
  param :trip_name, String
  def index
    trips = Trip.select(:name_place, :id).where("LOWER(name_place) ILIKE ?", "#{params[:trip_name].downcase}%")
    render json: trips, status: :ok
  end
end