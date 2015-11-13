class PagesController < ApplicationController
  before_action :authenticate_user!, only: :mytrips
  def index
    redirect_to mytrips_url if user_signed_in?
  end

  def mytrips
    @trips = current_user.joined_trips.includes(:group)
  end
end
