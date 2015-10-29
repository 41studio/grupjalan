class UsersController < ApplicationController
  def index
  	@users = User.order(first_name: :desc).page params[:page]
  end

  def show
    @user = User.find(params[:id])
  end

  def follow
    @user = User.find(params[:id])

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
    @user = User.find(params[:id])

    if current_user
      current_user.stop_following(@user)
      flash[:notice] = "You are no longer following #{@user.full_name}."
    else
      flash[:notice] = "You must <a href='/users/sign_in'>login</a> to unfollow #{@user.full_name}.".html_safe
    end
   redirect_to :back 
  end
end
