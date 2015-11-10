class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]

  def search
    @group = Group.new
  end

  def new
    @group = Group.new
    trip =  if params["group"]["trip_id"].blank?
              current_user.trips.create(name_place: params['group']['query'])
            else
              Trip.find(params["group"]["trip_id"])
            end

    @group = trip.groups.new(group_params)

    set_groups
  end

  def create
    @group = current_user.owned_groups.new(group_params)
    set_groups

    if @group.save
      @group.users << current_user unless @trip.users.include? current_user
      @group.trip.users << current_user unless @trip.users.include? current_user
      flash[:notice] =  'Plan anda berhasil dibuat.'
      redirect_to trip_group_path(@group.trip, @group)
    else
      render :new
    end
  end


  private
    def set_plan
      @group = Group.find(params[:id])
    end

    def set_groups
      @groups = Group.where(
        "trip_id = :trip_id AND start_to_trip < :end_to_trip AND end_to_trip > :start_to_trip",
        {
          start_to_trip: params[:group][:start_to_trip],
          end_to_trip: params[:group][:end_to_trip],
          trip_id: @group.trip.id
        }
      )
    end

    def group_params
      params.require(:group).permit(:trip_id, :start_to_trip, :end_to_trip, :lat, :lng, :group_name, :image, :photo, :category_id, :location)
    end
end
