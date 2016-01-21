# == Schema Information
#
# Table name: groups
#
#  id             :integer          not null, primary key
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#  location       :string
#  lat            :float
#  lng            :float
#  photo          :string
#  image          :string
#  slug           :string
#  destination_id :integer
#  categories     :text             default([]), is an Array
#  description    :text
#  members_count  :integer
#  featured       :boolean          default(FALSE)
#
# Indexes
#
#  index_groups_on_destination_id  (destination_id)
#  index_groups_on_slug            (slug) UNIQUE
#  index_groups_on_user_id         (user_id)
#

class GroupsController < ApplicationController
  load_and_authorize_resource
  
  before_action :authenticate_user!
  before_action :set_group, except: [:autocomplete, :index]
  before_action :set_new_trip, only: [:show, :members, :posts, :edit, :same, :update, :pribumis, :all_posts, :same_posts]
  before_action :find_post, only: [:show, :fetch_posts]

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
    redirect_to :back
  end

  def fetch_posts
    @posts = @group.posts.includes(:user, comments: [:user]).order(created_at: :desc)
    @members = @group.trips.includes(:user).all.limit(4)
    @pribumis = @group.trips.includes(:user).where(pribumi: true).all.limit(4)
    unless current_user.trips.where(group: @group).empty?
      @sames = @group.trips.joins(:group).includes(:user).where(
          "start_to_trip < :end_to_trip AND end_to_trip > :start_to_trip",
          {
            start_to_trip: current_user.trips.where(group: @group).first.start_to_trip,
            end_to_trip: current_user.trips.where(group: @group).first.end_to_trip,
            
          }
        ).all.limit(4)
    end
  end  

  def posts
    @post  = Post.new
    @posts = @group.posts.includes(:user, comments: [:user]).order(created_at: :desc)
    @action = 'posts'
    render :show
  end

  def all_posts
    @posts = @group.posts.includes(:user, comments: [:user]).order(created_at: :desc)
    @action = 'all_posts'
    render :show
  end 

  def same_posts
    @same_posts = @group.posts.includes(:user, comments: [:user]).where(
        "start_to_trip < :end_to_trip AND end_to_trip > :start_to_trip",
        {
          start_to_trip: current_user.trips.where(group: @group).first.start_to_trip,
          end_to_trip: current_user.trips.where(group: @group).first.end_to_trip,
        }

      ).order("created_at DESC")
    @action = 'same_posts'
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

  def pribumis
    @pribumis = @group.trips.includes(:user).where(pribumi: true)
    @action = 'pribumis'
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

    def find_post
      @post = Post.new
    end

    def set_group
      @group = Group.friendly.find(params[:id])
    end  

    def group_params
      params.require(:group).permit(:name, :location, :lat, :lng, :photo, :image, :categories, :description)
    end

    def trip_params
      params.require(:trip).permit(:start_to_trip, :end_to_trip, :pribumi)
    end
end


    
