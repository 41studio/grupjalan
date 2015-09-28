class GroupsController < InheritedResources::Base
  before_action :authenticate_user!
  
  def new_plan_step1

  end

  def new_plan_step2

  end 

  def new_plan_step3

  end 

  def autocomplete
    render json: Trip.search(params[:query], autocomplete: true, limit: 10).map {|trip| {name_place: trip.name_place, value: trip.id}}

  end  

  def new_plan_create_group
    
  end
  
  def new_plan_join_group

  end  

  private


    def group_params
      params.require(:group).permit(:group_name, :start_to_trip, :end_to_trip, :destination)
    end
end

