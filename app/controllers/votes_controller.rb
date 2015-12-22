class VotesController < ApplicationController
  before_action :set_post

  def upvote
    @post.upvote_by current_user
    render 'posts/vote'
  end
  
  def downvote
    @post.downvote_by current_user
    render 'posts/vote'
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end

end
