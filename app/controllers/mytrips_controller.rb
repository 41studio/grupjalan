class MytripsController < ApplicationController
  def index
    @trips_ids = current_user.groups.map(&:trip_id)
    @trips_ids = Trip.find(@trips_ids)
  end

  def show
  	@trip = Trip.find(params[:id])
    @groups = @trip.groups
    @post = Post.new
    @group_posts = @trip.posts.where(group_id: params[:group_id])
    @trip_posts = @trip.posts

    if params[:group_id].present?
      @group = Group.find(params[:group_id])
      @joined = @group.users.include? current_user
    end
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




