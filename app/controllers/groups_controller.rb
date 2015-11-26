class GroupsController < ApplicationController
  load_and_authorize_resource
  
  before_action :authenticate_user!
  before_action :set_group, except: [:autocomplete, :index]
  before_action :set_new_trip, only: [:show, :members, :posts, :edit]
  
  def autocomplete
    render json: Destination.select(:id, :name).where("name ILIKE ?", "#{params[:query]}%").limit(10)
  end

  def show
    @group_posts = @group.posts.includes(:user, comments: [:user]).by_group(@group.id)
    @group_messages = @group.messages.includes(:user).order("created_at desc")
    @message = Message.new
  end  

  def edit
    render :show
  end 

  def members
    @members = @group.trips.includes(:user)
    render "show"
  end

  def update
    if @group.update(group_params)
      flash[:success] = 'Grup berhasil diupdate.'
      redirect_to group_path(@group)
    else
      render :show
    end
  end

  def join
    trip = @group.trips.new(trip_params)
    trip.user_id = current_user.id
    if trip.save
      flash[:success] = 'Kamu berhasil gabung ke grup ini.'
      redirect_to :back
    else
      flash[:danger] = 'Tidak bisa gabung ke grup ini.'
      redirect_to :back
    end
  end

  def leave
    @group.users.delete(current_user)
    flash[:success] = "Kamu berhasil keluar dari grup ini."
    redirect_to group_path(@group)
  end

  def posts
    @post = Post.new
    @posts = @group.posts.includes(:user, comments: [:user]).order(created_at: :desc)
    render :show
  end

  def index
    @groups = Group.explore(params[:search]).page(params[:page])
  end

  private
    def set_trip
      @trip = Trip.friendly.find(params[:trip_id])
    end

    def set_new_trip
      @trip = Trip.new
    end

    def set_group
      @group = Group.friendly.find(params[:id])
    end  

    def group_params
      params.require(:group).permit(:name, :location, :lat, :lng, :photo, :image, :categories, :description)
    end

    def trip_params
      params.require(:trip).permit(:start_to_trip, :end_to_trip)
    end
end


    