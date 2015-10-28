class GroupsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_group, only: [:edit, :update, :leave, :join]
  
  def autocomplete
    render json: Trip.search(params[:query], autocomplete: true, limit: 10).map {|trip| {name_place: trip.name_place, value: trip.id}}
  end

  def edit

  end 

  def update
    if @group.update(group_params)
      flash[:success] = 'Grup berhasil diupdate.'
      redirect_to group_trip_path(@group.trip, @group)
    else
      render :edit
    end
  end

  def join
    @group.users << current_user
    flash[:success] = "Kamu berhasil join grup ini."
    redirect_to group_trip_path(@group.trip, @group)
  end

  def leave
    @group.users.delete(current_user)
    flash[:success] = "Kamu berhasil keluar dari grup ini."
    redirect_to group_trip_path(@group.trip, @group)
  end

  private
    def set_group
      @group = Group.find(params[:id])
    end  

    def group_params
      params.require(:group).permit(:group_name, :start_to_trip, :end_to_trip, :trip_id, :location, :lat, :lng, :photo, :image, :category_id)
    end
end


    