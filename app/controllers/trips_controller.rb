class TripsController < ApplicationController
  before_action :set_trip_and_groups, except: :popular
  before_action :build_post, only:   :group
  before_action :set_group,  except: [:show, :join, :leave, :members_trip, :popular]
  before_filter :build_post, only:   :show

  def show
    @trip_posts  = @trip.posts.includes(:user, comments: [:user]).order("created_at desc")
  end

  def join
    @trip.users << current_user 
    @trip.calculate_member_size
    flash[:success] = "Kamu berhasil join trip ini."
    redirect_to trip_path(@trip)
  end

  def leave
    @trip.users.delete(current_user)
    @trip.calculate_member_size
    flash[:success] = "Kamu berhasil keluar dari trip ini."
    redirect_to trip_path(@trip)
  end  

  def members_trip
    @members_trip = @trip.users
  end

  def popular
    @popular_trips = Trip.order(member_size: :desc).page params[:page]
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
