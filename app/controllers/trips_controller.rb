class TripsController < ApplicationController
  before_action :set_trip, :set_groups, :build_post

  def show
    @trip_posts = @trip.posts.includes(:user, :group, comments: [:user])
  end

  def group
    @group = Group.find(params[:group_id])
    @group_posts = @trip.posts.includes(:user, :group, comments: [:user]).by_group(@group.id)

    render "show"
  end

  private
    def set_groups
      @groups = @trip.groups
    end

    def set_trip
      @trip = Trip.friendly.find(params[:id])
    end

    def build_post
      @post = Post.new
    end

    def trip_params
      params.require(:trip).permit(:name_place)
    end
end
