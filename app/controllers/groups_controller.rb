class GroupsController < ApplicationController
  load_and_authorize_resource
  
  before_action :authenticate_user!
  before_action :set_group, except: [:autocomplete, :index]
  before_action :set_new_trip, only: [:show, :members, :posts, :edit, :same, :update]
  
  def autocomplete
    render json: Destination.select(:id, :name).where("name ILIKE ?", "#{params[:query]}%").limit(10)
  end

  def show
    @group_posts = @group.posts.includes(:user, comments: [:user]).by_group(@group.id)
    @group_messages = @group.messages.includes(:user).order("created_at desc")
    @message = Message.new
    @action = 'show'
  end  

  def edit
    @action = 'edit'
    render :show
  end 

  def members
    @members = @group.trips.includes(:user)
    @action = 'members'
    render :show
  end

  def update
    if @group.update(group_params)
      flash[:success] = 'Grup berhasil diupdate.'
      redirect_to group_path(@group)
    else
      @action = 'edit'
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
    @action = 'posts'
    render :show
  end

  def index
    @groups = Group.explore(params[:search]).page(params[:page])
  end

  def same
    @sames = @group.trips.joins(:group).includes(:user).where(
        "start_to_trip < :end_to_trip AND end_to_trip > :start_to_trip",
        {
          start_to_trip: current_user.trips.where(group: @group).first.start_to_trip,
          end_to_trip: current_user.trips.where(group: @group).first.end_to_trip,
        }
      )
    @action = 'same'
    render :show
  end  

  private


    def set_new_trip
      if user_signed_in? && !@group.user_ids.include?(current_user.id)
        @trip = Trip.new
      else   
        @trip = Trip.where(group_id: @group.id, user_id: current_user.id).first
      end  
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


    