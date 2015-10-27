class MytripsController < ApplicationController
  before_action :authenticate_user!

  def index
    @trips_ids = current_user.groups.map(&:trip_id)
    @trips_ids = Trip.find(@trips_ids)
  end

  def show
    @trip = Trip.find(params[:id])
    @groups = current_user.groups.by_trip(@trip)
    @groups_nj = @trip.groups.not_joined(@groups.map(&:id))
    @group_posts = @trip.posts.by_group(params[:group_id])
    @trip_posts = @trip.posts
    @post = Post.new

    if params[:group_id].present?
      @group = Group.find(params[:group_id])
      @joined = @group.users.include? current_user
    end

    @comments = @post.comments
  end

  def member
    @trip = Trip.find(params[:id])
    @group = Group.find(params[:group_id])
    @users = @group.users
  end
  
  def new

  end

end




