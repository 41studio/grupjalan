class Api::V1::TripsController < BaseApiController
  load_and_authorize_resource

  before_action :set_group
  before_action :set_trip, except: :create

  def_param_group :trip_params do
    param :trip, Hash do
      param :start_to_trip, String, required: true, desc: 'Date start for trip.'
      param :end_to_trip, String, required: true, desc: 'Date end for trip'
    end
  end

  api :POST, "/v1/groups/:group_id/trips", 'For join to group, should create trip.'
  param_group :trip_params
  def create
    if @group.user_ids.include? current_user.id
      render json: { success: 'Kamu sudah gabung ke grup ini sebelumnya.' }, status: :ok
    else
      trip = @group.trips.new(trip_params)
      trip.user_id = current_user.id

      if trip.save
        render json: { success: 'Berhasil gabung ke grup.' }, status: :ok
      else
        render json: { errors: trip.errors }, status: 401
      end
    end
  end

  api :PUT, "/v1/groups/:group_id/trips/:id", 'Update trip'
  param_group :trip_params
  def update
    if @trip.update(trip_params)
      render json: { success: 'Berhasil diupdate.' }, status: :ok
    else
      render json: { errors: @trip.errors }, status: 401
    end
  end

  api :DELETE, "/v1/groups/:group_id/trips/:id", 'Delete trip'
  param :id, String, desc: 'trip id'
  def destroy
    @trip.destroy

    render json: { success: 'Kamu sudah tidak bergabung dengan grup.' }, status: :ok
  end

  private
    def set_group
      @group = Group.find(params[:group_id])
    end

    def set_trip
      @trip = Trip.find(params[:id])
    end

    def trip_params
      params.require(:trip).permit(:start_to_trip, :end_to_trip)
    end
end