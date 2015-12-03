class Api::V1::CommentsController < BaseApiController
  load_and_authorize_resource

  before_action :set_post
  before_action :set_comment, except: :create

  def_param_group :comment do
    param :comment, Hash do
      param :comment, String, desc: 'Comment description'
    end
  end

  def_param_group :set_param do
    param :post_id, String, required: true, desc: 'Post id'
    param :id, String, desc: 'Comment id'
  end

  api :POST, "/v1/posts/:post_id/comments", 'Create comment by id post'
  param_group :comment
  param :post_id, String, required: true, desc: 'Post id'
  def create
    comment = @post.comments.new(comment_params)
    comment.user_id = current_user.id

    if comment.save
      render json: { success: 'Berhasil mengomentari postingan.' }, status: :ok
    else
      render json: { errors: comment.errors }, status: 401
    end
  end

  api :PUT, "/v1/posts/:post_id/comments/:id", 'Update comment'
  param_group :set_param
  def update
    if @comment.update(comment_params)
      render json: { success: 'Komentar berhasil diedit.' }, status: :ok
    else
      render json: { errors: @comment.errors }, status: 401
    end
  end

  api :DELETE, "/v1/posts/:post_id/comments/:id", 'Delete comment'
  param_group :set_param
  def destroy
    @comment.destroy

    render json: { success: 'Komentar berhasil dihapus.' }, status: :ok
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:comment)
    end
end