class PagesController < ApplicationController
  def index
    redirect_to mytrips_url if user_signed_in?
  end

  def mytrips
    trips_ids = current_user.groups.map(&:trip_id)
    @trips = Trip.find(trips_ids)
  end
end
