class Api::V1::GroupsController < BaseApiController
  load_and_authorize_resource

  before_action :set_group, only: [:update, :destroy]

  def_param_group :search_group do
    param :start_to_trip, String, "Start to trip for group, format: 'dd/mm/yyyy'"
    param :end_to_trip, String, "End to trip for group, format: 'dd/mm/yyyy'"
    param :name, String, "Group name"
    param :page, String, "Pagination page number"
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
  example '[
    {
      "id": 7,
      "name": "Bali Grup",
      "lat": -8.71913635551828,
      "lng": 115.161450179688,
      "location": "Jl. Raya Kuta No.4, Kuta, Kabupaten Badung, Bali 80361, Indonesia",
      "categories": ["Taman", "Laut", "Wisata"],
      "description": "Lorem ipsum",
      "created_at": "2015-11-18T10:41:51.448+07:00",
      "image": {
        "original": "/uploads/group/image/7/rainbow.png",
        "small": "/uploads/group/image/7/logo_rainbow.png"
      },
      "photo": {
        "original": "/uploads/group/photo/7/glacier_national_park_dual_monitor-other.jpg",
        "small": "/uploads/group/photo/7/small_glacier_national_park_dual_monitor-other.jpg",
        "medium": "/uploads/group/photo/7/medium_glacier_national_park_dual_monitor-other.jpg",
        "cover": "/uploads/group/photo/7/cover_glacier_national_park_dual_monitor-other.jpg"
      }
    },
    {
      "id": 8,
      "name": "Bali Grup AGain",
      "lat": -8.7237964,
      "lng": 115.1752277,
      "location": "Jl. Buni Sari No.24, Kuta, Kabupaten Badung, Bali 80361, Indonesia",
      "categories": ["Laut", "Wisata"],
      "description": "Lorem ipsum",
      "created_at": "2015-11-18T10:42:44.317+07:00",
      "image": {
        "original": "/uploads/group/image/8/Eiffel_Tower__Paris.jpg",
        "small": "/uploads/group/image/8/logo_Eiffel_Tower__Paris.jpg"
      },
      "photo": {
        "original": "/uploads/group/photo/8/14588_10152526541956989_2051647669486688192_n.jpg",
        "small": "/uploads/group/photo/8/small_14588_10152526541956989_2051647669486688192_n.jpg",
        "medium": "/uploads/group/photo/8/medium_14588_10152526541956989_2051647669486688192_n.jpg",
        "cover": "/uploads/group/photo/8/cover_14588_10152526541956989_2051647669486688192_n.jpg"
      }
    }
  ]'
  def search
    @groups = Group.joins(:trips).where(
      "LOWER(groups.name) ILIKE :name AND (trips.start_to_trip <= :start_to_trip AND trips.end_to_trip >= :end_to_trip)
      OR (:start_to_trip <= trips.start_to_trip AND :end_to_trip >= trips.end_to_trip)", 
      {
        start_to_trip: params[:start_to_trip].to_date,
        end_to_trip: params[:end_to_trip].to_date,
        name: "%#{params[:name].downcase}%"
      }
    ).page(params[:page])
  end

  api :GET, '/v1/groups', "get groups, with pagination, order"
  param :page, String, desc: 'Pagination page'
  param :order_by, String, desc: 'Order by column'
  param :order_type, String, desc: 'Order type desc or asc'
  def index
    @groups = Group.order_by(params[:order_by], params[:order_type]).page(params[:page])
  end

  api :GET, "/v1/groups/:id", 'get detail group'
  param :id, String, "Group id"
  def show
    @group = Group.includes(posts: [:user, comments: [:user]]).find(params[:id])
  end

  api :POST, "/v1/groups", 'create group and create new trip'
  param_group :create_group
  def create
    @group = current_user.owned_groups.new(group_params)
    
    if @group.save
      trip = @group.trips.new(trip_params)
      trip.user_id = current_user.id
      trip.save
      
      render :show
    else
      render json: { errors: @group.errors }, status: 401
    end
  end

  api :DELETE, "/v1/groups/:id", 'delete group'
  param :id, String, "Group id"
  def destroy
    @group.destroy

    render json: { success: 'Grup berhasil dihapus' }, status: :ok
  end

  api :PUT, "/v1/groups/:id", 'update group'
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
      params.require(:group).permit(:name, :location, :lat, :lng, :photo, :image, :description, categories: [])
    end
end