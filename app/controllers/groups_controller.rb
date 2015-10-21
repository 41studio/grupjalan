class GroupsController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :set_group, only: [:edit, :update]  
  
  def new_plan_step1

  end


  def new_plan_step2
    unless params[:trip_id].present?
      trip = current_user.trips.first_or_create(name_place: params[:group][:query])
      params[:trip_id] = trip.id
    end
    @group = Group.new(group_params)
    @groups = Group.where("trip_id = :trip_id AND start_to_trip < :end_to_trip AND end_to_trip > :start_to_trip", { start_to_trip: params[:group][:start_to_trip], end_to_trip: params[:group][:end_to_trip], trip_id: params[:group][:trip_id]})
  end

  def autocomplete
    render json: Trip.search(params[:query], autocomplete: true, limit: 10).map {|trip| {name_place: trip.name_place, value: trip.id}}
  end  

  def new_plan_create_group
    @group = current_user.owned_groups.new(group_params)

    if @group.save
      @group.users << current_user
      redirect_to @group, notice: 'grup jalan-jalan sudah berhasil di buat'
    else
      @groups = Group.where(group_params)
      render :new_plan_step2
    end
    
  end
  
  def new_plan_join_group
    group = Group.find(params[:group_id])
    group.users << current_user
    redirect_to group, notice: 'Kamu sudah join dengan grup ini'
  end 

  def edit

  end 

  def update
     respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to mytrips_show_path(@group.trip.id, group_id: @group.id), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end  

  private
    def set_group
      @group = Group.find(params[:id])
    end  

    def group_params
      params.require(:group).permit(:group_name, :start_to_trip, :end_to_trip, :trip_id, :location, :lat, :lng, :photo, :image, :category_id)
    end
end


    