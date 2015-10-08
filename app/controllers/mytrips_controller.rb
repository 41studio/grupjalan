class MytripsController < ApplicationController
  def index
    @trips_ids = current_user.groups.map(&:trip_id)
    @trips_ids = Trip.find(@trips_ids)
  end

  def show
  	@trip = Trip.find(params[:id])
    @groups = @trip.groups

    if params[:group_id].present?
      @group = Group.find(params[:group_id])
    end
  end

  def new
  end

  def create

  end	
end




