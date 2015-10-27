class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :set_group

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = current_user.posts.new
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

  def create_comment
    
  end 

  def destroy_comment
     @post = Post.find(params[:post])
     @comment = current_user.comments.find(params[:id_comment])
     @comment.destroy

     redirect_to :back
  end 

  def upvote
    @post.upvote_by current_user
    redirect_to :back
  end
  
  def downvote
    @post.downvote_by current_user
    redirect_to :back
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        flash[:success] = 'Post berhasil diupdate.'
        format.html { redirect_to group_trip_path(@group.trip, @group) }
        format.json { render :show, status: :ok, location: @post }
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
