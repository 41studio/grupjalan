class TripsController < ApplicationController
  before_action :set_trip_and_groups
  before_action :build_post, only: :group
  before_action :set_group, except: :show
  before_filter :build_post, only: [:show]

  def show
    @trip_posts  = @trip.posts.includes(:user, comments: [:user])
  end


  private

    def build_post
      @post = Post.new
    end

    def set_trip_and_groups
      @trip = Trip.friendly.find(params[:id])
      @groups = @trip.groups
    end


    def set_group
      @group = Group.find(params[:group_id])
    end

    def trip_params
      params.require(:trip).permit(:name_place)
    end
end
