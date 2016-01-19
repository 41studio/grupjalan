# == Schema Information
#
# Table name: posts
#
#  id                      :integer          not null, primary key
#  title                   :string
#  photo                   :string
#  video                   :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  user_id                 :integer
#  description             :text
#  trip_id                 :integer
#  group_id                :integer
#  comments_count          :integer          default(0)
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#
# Indexes
#
#  index_posts_on_cached_votes_down        (cached_votes_down)
#  index_posts_on_cached_votes_score       (cached_votes_score)
#  index_posts_on_cached_votes_total       (cached_votes_total)
#  index_posts_on_cached_votes_up          (cached_votes_up)
#  index_posts_on_cached_weighted_average  (cached_weighted_average)
#  index_posts_on_cached_weighted_score    (cached_weighted_score)
#  index_posts_on_cached_weighted_total    (cached_weighted_total)
#  index_posts_on_group_id                 (group_id)
#  index_posts_on_trip_id                  (trip_id)
#  index_posts_on_user_id                  (user_id)
#

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
      @success = true
      
    else
      @success = false
      
    end
  end

  def update
    if @post.update(post_params)
      flash[:success] = 'Postingan berhasil diupdate.'
      redirect_to posts_group_path(@post.group)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    # flash[:success] = 'Post berhasil dihapus.'

    # redirect_to :back
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
      params.require(:post).permit(:description, :photo, :video)
    end
end
