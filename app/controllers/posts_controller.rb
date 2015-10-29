class PostsController < ApplicationController
  before_action :find_post, only: %i(show edit update destroy upvote downvote)
  


  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  def home
   redirect_to mytrips_index_path if user_signed_in?
  end  

  def quotes
    
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = current_user.posts.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @user = current_user
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to :back, notice: 'Post was successfully created.'
    else
      redirect_to :back, notice: 'Create Post Failed'
    end

  end

  def create_comment
    @post = Post.find(params[:comment][:post_id])
    @user = @post.user
    @comment = current_user.comments.new
    @comment.comment = params[:comment][:comment]
    @comment.commentable = @post
    @comment.save
    @comments = @post.comments
    redirect_to :back
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

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to mytrips_show_path(@post.trip.id, group_id: @post.group.id), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def find_post
      @post = current_user.posts.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :description, :photo, :video, :group_id, :trip_id)
    end
end
