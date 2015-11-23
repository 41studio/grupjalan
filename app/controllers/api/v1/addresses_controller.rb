class Api::V1::AddressesController < BaseApiController
  skip_before_action :authenticate_user_from_token!
  
  api :GET, '/v1/countries', 'Get all countries'
  example JSON.pretty_generate Country.select(:id, :name).map {|country| country.attributes}
  def countries
    render json: Country.select(:id, :name), status: :ok
  end

  api :GET, '/v1/provinces', 'Get all provinces by country_id'
  param :country_id, String, required: true, desc: 'Country ID'
  example JSON.pretty_generate Country.first.areas.select(:id, :name, :country_id).limit(3).map {|area| area.attributes}
  def provinces
    country = Country.find(params[:country_id])
    render json: country.areas.select(:id, :name, :country_id), status: :ok
  end

  api :GET, '/v1/cities', 'Get all cities by province_id'
  param :province_id, String, required: true, desc: 'Province ID'
  example JSON.pretty_generate Area.first.cities.select(:id, :name, "area_id AS province_id").limit(3).map {|area| area.attributes}
  def cities
    area = Area.find(params[:province_id])
    render json: area.cities.select(:id, :name, 'area_id AS province_id'), status: :ok
  end
end
