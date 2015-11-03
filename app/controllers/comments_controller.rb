class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      flash['success'] = 'Berhasil membuat komen.'
    else
      flash['danger'] = 'Komen gagal dibuat.'
    end

    redirect_to_group
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    
    flash['success'] = 'Komen berhasil dihapus.'

    redirect_to_group
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end

    def comment_params
      params.require(:comment).permit(:comment)
    end

    def redirect_to_group
      redirect_to :back
    end
end
