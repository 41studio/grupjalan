class UsersController < ApplicationController
  before_filter :set_user, only: [:show, :message, :follow, :unfollow]

  def index
  	@users = User.order(first_name: :desc).page params[:page]
  end

  def show
  end

  def follow

    if current_user
      if current_user == @user
        flash[:notice] = "You cannot follow yourself."
      else
        current_user.follow(@user)
        flash[:notice] = "You are now following #{@user.full_name}."
      end
    else
      flash[:notice] = "You must <a href='/users/sign_in'>login</a> to follow #{@user.full_name}.".html_safe
    end

    redirect_to :back
  end

  def unfollow

    if current_user
      current_user.stop_following(@user)
      flash[:danger] = "You are no longer following #{@user.full_name}."
    else
      flash[:notice] = "You must <a href='/users/sign_in'>login</a> to unfollow #{@user.full_name}.".html_safe
    end
   redirect_to :back 
  end

  private

  def set_user
    @user = User.find(params[:id])
  end  
end
