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

  def mytrips_join_group
    @group = Group.find(params[:group_id])
    @group.users << current_user
    redirect_to @group, notice: 'kamu sudah join dengan grup ini'
  end 

  def mytrips_leave_group
    groups = Group.find(params[:group_id])
    groups.users.delete(current_user)
    redirect_to groups, notice: 'kamu sudah keluar dari group ini' 
  end

  def new

  end

end




