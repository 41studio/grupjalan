class GroupsController < InheritedResources::Base
  before_action :authenticate_user!
  
  def new_plan_step1

  end

  def new_plan_step2

  end 

  def new_plan_step3

  end 

  def auto_complete_plan

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

