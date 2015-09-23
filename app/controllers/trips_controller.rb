class TripsController < InheritedResources::Base

	

  private

    def trip_params
      params.require(:trip).permit(:name_place)
    end
end

