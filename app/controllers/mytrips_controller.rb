class MytripsController < ApplicationController
  def index
    @trips_ids = current_user.groups.map(&:trip_id)
    @trips_ids = Trip.find(@trips_ids)
  end

  def show
  	@groups_ids = current_user.groups.map(&:id)
  	@groups_ids = Group.find(@groups_ids)
  	@trips_ids  = Trip.find(params[:id])
  end	
end
