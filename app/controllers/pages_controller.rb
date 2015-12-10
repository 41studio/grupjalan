class PagesController < ApplicationController
  before_action :authenticate_user!, only: :mytrips

  def index
    redirect_to mytrips_url if user_signed_in?
  end

  def mytrips
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

  end
end
