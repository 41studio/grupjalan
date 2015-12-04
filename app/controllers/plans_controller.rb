class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]

  def search
    @trip = Trip.new
  end

  def new
    @group = Group.new

    set_trips
  end

  def create
    @group = current_user.owned_groups.new(group_params)
    
    if @group.save
      trip = @group.trips.new(trip_params)
      trip.user = current_user
      trip.save
      flash[:notice] =  'Grup berhasil dibuat.'
      redirect_to group_url(@group)
    else
      set_trips
      render :new
    end
  end


  private
    def set_plan
      @group = Group.find(params[:id])
    end

    def set_trips
      @trips = Trip.joins(:group).where(
        "LOWER(groups.name) ILIKE :name AND start_to_trip < :end_to_trip AND end_to_trip > :start_to_trip",
        {
          start_to_trip: (params[:trip][:start_to_trip].to_date rescue nil),
          end_to_trip: (params[:trip][:end_to_trip].to_date rescue nil),
          name: "%#{params[:query].downcase}%"
        }
      )
     
    end

    def trip_params
      params.permit(:start_to_trip, :end_to_trip)
    end

    def group_params
      params.require(:group).permit(:lat, :lng, :name, :image, :photo, :location, :destination_id)
    end
end
