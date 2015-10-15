class GroupsController < InheritedResources::Base
  before_action :authenticate_user!
  
  def new_plan_step1

  end

  def new_plan_step2
    unless params[:trip_id].present?
      trip = current_user.trips.first_or_create(name_place: params[:query])
      params[:trip_id] = trip.id
    end
  end 

  def new_plan_step3
    @group = Group.new(group_params)
    @groups = Group.where(group_params)
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
      render :new_plan_step3
    end
    
  end
  
  def new_plan_join_group
    group = Group.find(params[:group_id])
    group.users << current_user
    redirect_to group, notice: 'Kamu sudah join dengan grup ini'
  end  

  private


    def group_params
      params.require(:group).permit(:group_name, :start_to_trip, :end_to_trip, :trip_id, :location, :lat, :lng, :photo)
    end
end

before_action :redirect_https

    def redirect_https        
      redirect_to :protocol => "https://" unless request.ssl?
      return true 
    end
    