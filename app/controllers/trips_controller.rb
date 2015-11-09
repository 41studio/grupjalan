class TripsController < ApplicationController
  before_action :set_trip_and_groups
  before_action :build_post, only:   :group
  before_action :set_group,  except: [:show, :join, :leave, :members_trip]
  before_filter :build_post, only:   :show

  def show
    @trip_posts  = @trip.posts.includes(:user, comments: [:user]).order("created_at desc")
  end

  def join
    @trip.users << current_user
    flash[:success] = "Kamu berhasil join trip ini."
    redirect_to trip_path(@trip)
  end

  def leave
    @trip.users.delete(current_user)
    flash[:success] = "Kamu berhasil keluar dari trip ini."
    redirect_to trip_path(@trip)
  end  

  def members_trip
    @members_trip = @trip.users
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
      params.require(:trip).permit(:name_place, :group_id)
    end
end
