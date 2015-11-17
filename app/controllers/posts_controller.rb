class PostsController < ApplicationController

  before_action :find_post, only: [:edit, :update, :destroy]
  before_action :set_group, only: :create

  def index
    @posts = current_user.posts.includes(:trip) 
  end

  def edit

  end

  def create
    @post = current_user.posts.new(post_params)
    @post.group = @group

    if @post.save
      flash[:success] = 'Post berhasil dibuat.'
      redirect_to :back
    else
      flash[:danger]  = 'Post gagal dibuat.'
      redirect_to :back
    end
  end

  def update
    if @post.update(post_params)
      flash[:success] = 'Post berhasil diupdate.'
      redirect_to :back
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'Post berhasil dihapus.'

    redirect_to :back
  end

  private
    def find_post
      if current_user.is_administrator?
        @post = Post.find(params[:id])
      else
        @post = current_user.posts.find(params[:id])
      end
    end

    def set_group
      @group = Group.friendly.find(params[:group_id])
    end

    def post_params
      params.require(:post).permit(:description, :photo)
    end
end
