class Api::V1::PostsController < BaseApiController
  load_and_authorize_resource

  before_action :set_group
  before_action :set_post, except: :create

  def_param_group :group do
    param :post, Hash do
      param :description, String, required: true, desc: 'Description post'
      param :photo, ActionDispatch::Http::UploadedFile, desc: 'Photo for post'
    end
  end

  def_param_group :set_param do
    param :group_id, String, required: true, desc: 'Group id'
    param :id, String, required: true, desc: 'Post id'
  end

  api :POST, "/v1/groups/:group_id/posts", 'Create post for group'
  param :group_id, String, required: true, desc: 'Group id'
  param_group :group
  def create
    @post = @group.posts.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      render :show
    else
      render json: { errors: @post.errors }, status: 401
    end
  end

  api :DELETE, "/v1/groups/:group_id/posts/:id", 'Delete post by id'
  param_group :set_param
  def destroy
    @post.destroy
    
    render json: { success: 'Postingan berhasil dihapus' }, status: :ok
  end

  api :PUT, "/v1/groups/:group_id/posts/:id", 'Update post by id'
  param_group :set_param
  param_group :group
  def update
    if @post.update(post_params)
      render :show
    else
      render json: { errors: @post.errors }, status: 401
    end
  end

  api :POST, "/v1/groups/:group_id/posts/:id/upvote", "Upvote/like post by id"
  param_group :set_param
  def upvote
    @post.upvote_by current_user

    render json: { success: 'Berhasil like postingan.' }, status: :ok
  end

  api :DELETE, "/v1/groups/:group_id/posts/:id/downvote", "Downvote/dislike post by id"
  param_group :set_param
  def downvote
    @post.downvote_by current_user

    render json: { success: 'Berhasil dislike postingan.' }, status: :ok
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def set_group
      @group = Group.find(params[:group_id])
    end

    def post_params
      params.require(:post).permit(:description, :photo)
    end
end
