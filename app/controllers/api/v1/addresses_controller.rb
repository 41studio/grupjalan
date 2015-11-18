class Api::V1::AddressesController < BaseApiController
  api :GET, '/v1/countries', 'Get all countries'
  def countries
    render json: Country.select(:id, :name), status: :ok
  end

  api :GET, '/v1/provinces', 'Get all provinces by country_id'
  param :country_id, String, desc: 'Country ID'
  def provinces
    country = Country.find(params[:country_id])
    render json: country.areas.select(:id, :name, :country_id), status: :ok
  end

  api :GET, '/v1/cities', 'Get all cities by province_id'
  param :province_id, String, desc: 'Province ID'
  def cities
    area = Area.find(params[:province_id])
    render json: area.cities.select(:id, :name, 'area_id AS province_id'), status: :ok
  end
end
