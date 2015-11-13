class SyncController < ApplicationController
  def get_provinces
    country = Country.find_by(name: params[:country])
    @provinces = country.areas.pluck(:name)
  end

  def get_cities
    area = Area.find_by(name: params[:province])
    @cities = area.cities.pluck(:name)
  end
end
