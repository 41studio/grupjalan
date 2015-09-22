class GroupsController < InheritedResources::Base
  before_action :authenticate_user!

  private

    def group_params
      params.require(:group).permit(:group_name, :start_to_trip, :end_to_trip)
    end
end

