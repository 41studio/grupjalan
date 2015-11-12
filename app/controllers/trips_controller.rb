class TripsController < ApplicationController
  before_action :set_trip
  before_action :build_post, only: [:show, :members]
  before_action :set_group, except: :show

  def show
    @group = @trip.group
    @posts = @trip.posts.includes(:user, :group, comments: [:user])
  end

  def group
    @group_posts = @trip.posts.includes(:user, :group, comments: [:user]).by_group(@group.id)

    render "show"
  end

  def members
    @members = @trip.users
    @posts = @trip.posts.includes(:user, :group, comments: [:user])
    
    render "show"
  end

  def leave
    @trip.users.delete(current_user)
    flash[:success] = "Kamu berhasil keluar dari trip ini."
    redirect_to group_trip_path(@group, @trip)
  end

  def join
    @trip.users << current_user
    flash[:success] = "Kamu berhasil join trip ini."
    redirect_to group_trip_path(@group, @trip)
  end

  private
    def set_trip
      @trip = Trip.find(params[:id])
    end

    def build_post
      @post = Post.new
    end

    def set_group
      @group = Group.friendly.find(params[:group_id])
    end

    def trip_params
      params.require(:trip).permit(:name_place)
    end
end
