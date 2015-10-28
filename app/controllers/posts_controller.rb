class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :destroy]
  before_action :set_group, except: [:index, :new, :quotes]

  def index
    @posts = current_user.posts.includes(:trip, :group)
  end

  def edit
  end

  def create
    @post = current_user.posts.new(post_params)

    @post.group = @group
    @post.trip = @group.trip

    if @post.save
      flash[:success] = 'Post berhasil dibuat.'
      redirect_to group_trip_path(@group.trip, @group)
    else
      flash[:danger] = 'Post gagal dibuat.'
      redirect_to group_trip_path(@group.trip, @group)
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        flash[:success] = 'Post berhasil diupdate.'
        format.html { redirect_to group_trip_path(@group.trip, @group) }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'Post berhasil dihapus.'

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private
    def find_post
      @post = current_user.posts.find(params[:id])
    end

    def set_group
      @group = Group.find(params[:group_id])
    end

    def post_params
      params.require(:post).permit(:title, :description, :photo, :video, :group_id, :trip_id)
    end
end
