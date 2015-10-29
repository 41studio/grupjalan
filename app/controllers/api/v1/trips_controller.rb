class Api::V1::TripsController < BaseApiController
  def index
    render json: {hello: 'world'}
  end
end