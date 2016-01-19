# == Schema Information
#
# Table name: trips
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#  slug           :string
#  start_to_trip  :date
#  end_to_trip    :date
#  group_id       :integer
#  member_size    :integer          default(0)
#  destination_id :integer
#  pribumi        :boolean          default(FALSE)
#
# Indexes
#
#  index_trips_on_destination_id  (destination_id)
#  index_trips_on_group_id        (group_id)
#  index_trips_on_member_size     (member_size)
#  index_trips_on_slug            (slug) UNIQUE
#  index_trips_on_user_id         (user_id)
#

class TripsController < ApplicationController
  before_action :set_trip
  # before_action :build_post, only: [:show, :members]
  before_action :set_group, except: :show

  def show
    @group = @trip.group
    @posts = @trip.posts.includes(:user, :group, comments: [:user])
  end

  # def join
  #   @trip.users << current_user 
  #   @trip.calculate_member_size
  #   flash[:success] = "Kamu berhasil join trip ini."
  #   redirect_to trip_path(@trip)
  # end

  def members
    @members = @trip.users
    @posts = @trip.posts.includes(:user, :group, comments: [:user])
    
    render :show
  end

  # def leave
  #   @trip.users.delete(current_user)
  #   flash[:success] = "Kamu berhasil keluar dari trip ini."
  #   redirect_to group_trip_path(@group, @trip)
  # end

  # def popular
  #  @popular_trips = Trip.order(member_size: :desc).page params[:page]
  # end  

  # def join
  #   @trip.users << current_user
  #   flash[:success] = "Kamu berhasil join trip ini."
  #   redirect_to group_trip_path(@group, @trip)
  # end

  def update
    if @trip.update(trip_params)
      flash[:success] = 'Tanggal berhasil diupdate.'
    else
      flash[:success] = 'Tanggal tidak boleh kosong'
    end  
      redirect_to group_path(@group)
  end  

  private
    def set_trip
      @trip = Trip.find(params[:id])
    end


    def set_group
      @group = Group.friendly.find(params[:group_id])
    end

    def trip_params
      params.require(:trip).permit(:name_place, :group_id, :start_to_trip, :end_to_trip, :pribumi)
    end
end
