# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string
#  uid                    :string
#  photo                  :string
#  username               :string
#  first_name             :string
#  last_name              :string
#  neighborhood           :string
#  address                :text
#  gender                 :string           default("male")
#  handphone              :string
#  status                 :string
#  video                  :string
#  country                :string
#  city                   :string
#  province               :string
#  role                   :integer          default(0)
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  birthday               :date
#  auth_token             :string
#  image                  :string
#
# Indexes
#
#  index_users_on_auth_token            (auth_token) UNIQUE
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_provider              (provider)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid                   (uid)
#

class UsersController < ApplicationController
  before_filter :set_user, only: [:show, :message, :follow, :unfollow, :edit, :update, :edit_profile]

  def index
  	@users = User.order(first_name: :desc).page params[:page]
  end

  def show
    @action = 'show'
  end

  def edit
    @action = 'edit'
    render :show
  end  

  def edit_profile

  end  

  def update
    if @user.update(user_params)
      flash[:success] = 'Data User berhasil diupdate.'
      redirect_to root_path
    else
      @action = 'edit'
      render :show
    end
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

  def user_params
    params.require(:user).permit(:photo, :video, :username, :first_name, :last_name, :neighborhood, :address, :gender, :brithday, :handphone, :status, :role, :country, :city, :province, :image)
  end  
end
