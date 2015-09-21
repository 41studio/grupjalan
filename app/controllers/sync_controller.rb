class SyncController < ApplicationController
  def get_provinces
  	@provinces = CS.states(params[:country_code])
  end

  def get_cities
  	@cities = CS.cities(params[:province_code])	
  end
end
