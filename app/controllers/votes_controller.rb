class VotesController < ApplicationController
  before_action :set_post

  def upvote
    @post.upvote_by current_user
    flash['success'] = 'Post berhasil dilike.'
    redirect_to :back
  end
  
  def downvote
    @post.downvote_by current_user
    flash['success'] = 'Post berhasil diunlike.'
    redirect_to :back
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end

end
