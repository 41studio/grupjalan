class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      @success = true
    else
      @success = false
    end
  end


  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end

    def comment_params
      params.require(:comment).permit(:comment)
    end
end
