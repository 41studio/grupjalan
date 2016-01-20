class PagesController < ApplicationController
  before_action :authenticate_user!, only: :mytrips

  def index
    @groups = Group.order("created_at DESC").all.limit(8)
    redirect_to mytrips_url if user_signed_in?
  end

  def mytrips
    @groups = Group.order("created_at ASC").all.limit(5)
    @trips = current_user.trips.includes(:group).where(
      "end_to_trip >= :end_to_trip",
      {
        end_to_trip: Time.now
      }
    )

    @old_trips = current_user.trips.includes(:group).where(
      "end_to_trip < :end_to_trip",
      {
        end_to_trip: Time.now
      }
    )

    @pribumis = current_user.trips.includes(:group).where(pribumi: true)

  end

  def about
    
  end  
end
