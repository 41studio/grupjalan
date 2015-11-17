class Api::V1::GroupsController < BaseApiController
  load_and_authorize_resource

  before_action :set_group, only: [:update, :destroy]

  def_param_group :search_group do
    param :start_to_trip, String, "Start to trip for group, format: 'dd/mm/yyyy'"
    param :end_to_trip, String, "End to trip for group, format: 'dd/mm/yyyy'"
    param :name, String, "Group name"
  end

  def_param_group :create_group do
    param :group, Hash do
      param :name, String, required: true, desc: "Name for group"
      param :lat, String, required: true, desc: "Latitude map"
      param :lng, String, required: true, desc: "Longitude map"
      param :image, ActionDispatch::Http::UploadedFile, "logo image for group"
      param :photo, ActionDispatch::Http::UploadedFile, "cover image for group"
      param :location, String, required: true, desc: "location or address"
      param :categories, Array, in: ['Laut', 'Wisata', 'Taman', 'Pantai'], desc: "categories ex: ['Laut', 'Wisata', 'Taman']"
      param :description, String
    end
  end

  api :GET, "/v1/groups/search", 'search group by name group, trip start_to_trip and trip end_to_trip'
  param_group :search_group
  def search
    @groups = Group.joins(:trips).where(
      "LOWER(groups.name) ILIKE :name AND trips.start_to_trip = :start_to_trip AND trips.end_to_trip >= :end_to_trip", 
      {
        start_to_trip: params[:start_to_trip].to_date,
        end_to_trip: params[:end_to_trip].to_date,
        name: "%#{params[:name].downcase}%"
      }
    )
  end

  api :GET, "v1/groups/:id", 'get detail group'
  param :id, String, "Group id"
  def show
    @group = Group.includes(posts: [:user, comments: [:user]]).find(params[:id])
  end

  api :POST, "v1/groups", 'create group and create new trip'
  param_group :create_group
  def create
    user = User.find_by(auth_token: params[:auth_token])
    @group = user.owned_groups.new(group_params)
    
    if @group.save
      trip = @group.trips.new(trip_params)
      trip.user_id = user.id
      trip.save
      
      render json: { id: @group.id, name: @group.name }, status: :ok
    else
      render json: { errors: @group.errors }, status: 401
    end
  end

  api :DELETE, "v1/groups/:id", 'delete group'
  param :id, String, "Group id"
  def destroy
    @group.destroy

    render json: { success: 'Grup berhasil dihapus' }, status: :ok
  end

  api :PUT, "v1/groups/:id", 'update group'
  param :id, String, "Group id"
  param_group :create_group
  def update
    if @group.update(group_params)
      render :show
    else
      render json: { errors: @group.errors }, status: 401
    end
  end

  private
    def set_group
      @group = Group.find(params[:id])
    end

    def trip_params
      params.permit(:start_to_trip, :end_to_trip)
    end

    def group_params
      params.require(:group).permit(:name, :location, :lat, :lng, :photo, :image, :categories, :description)
    end
end