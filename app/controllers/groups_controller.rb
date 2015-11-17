class GroupsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_group, except: :autocomplete
  
  def autocomplete
    render json: Destination.select(:id, :name).where("name ILIKE ?", "#{params[:query]}%").limit(10)
  end


  def show
    @group_posts = @group.posts.includes(:user, comments: [:user]).by_group(@group.id)
    @group_messages = @group.messages.includes(:user).order("created_at desc")
    @message = Message.new

  end  

  def edit

  end 

  def members
    @members = @group.users
  end

  def update
    if @group.update(group_params)
      flash[:success] = 'Grup berhasil diupdate.'
      redirect_to trip_group_path(@group.trip, @group)
    else
      render :edit
    end
  end

  def join
    @group.users << current_user unless @group.users.include? current_user
    flash[:success] = "Kamu berhasil join grup ini."
    redirect_to group_path(@group)
  end

  def leave
    @group.users.delete(current_user)
    flash[:success] = "Kamu berhasil keluar dari grup ini."
    redirect_to group_path(@group)
  end

  private

    def set_trip
      @trip = Trip.friendly.find(params[:trip_id])
    end

    def set_group
      @group = Group.friendly.find(params[:id])
    end  

    def group_params
      params.require(:group).permit(:group_name, :start_to_trip, :end_to_trip, :trip_id, :location, :lat, :lng, :photo, :image, :category_id)
    end
end


    