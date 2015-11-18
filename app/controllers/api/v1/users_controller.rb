class Api::V1::UsersController < BaseApiController
  skip_before_action :authenticate_user_from_token!, only: [:sign_in_email, :register, :sign_out]
  before_action :set_user, only: [:show, :update]
  before_action :verify_user, only: :update

  def_param_group :authentication do
    param :auth_token, String, desc: "auth_token user for request api", required: true
  end

  def_param_group :user do
    param :user, Hash do
      param :first_name, String, required: true
      param :last_name, String, required: true
      param :email, String, required: true
      param :username, String, required: true
      param :password, String
      param :password_confirmation, String
    end
  end

  def_param_group :user_update do
    param_group :user
    param :user, Hash do
      param :status, String
      param :neighborhood, String
      param :address, String
      param :gender, String, desc: "value should 'male' or 'female'"
      param :birthday, String, desc: 'dd/mm/yyyy'
      param :handphone, String
      param :country, String, desc: 'data from /api/v1/countries'
      param :city, String, desc: 'data from /api/v1/cities'
      param :province, String, desc: 'data from /api/v1/provinces'
    end
  end

  api :POST, '/v1/users/sign_in_email', 'Sign in with email'
  param :email, String, required: true
  param :password, String, required: true
  def sign_in_email
    email = params[:email]
    password = params[:password]

    if (email.present? && password.present?) && ((user = User.find_by(email: email)) && user.valid_password?(password))
      if user.confirmed?
        user.auth_token = user.generate_auth_token
        user.save

        render json: user, status: :ok
      else
        render json: { error: "Mohon konfirm email kamu." }, status: :unprocessable_entity
      end
    else
      render json: { error: "Email atau kata sandi tidak valid." }, status: :unprocessable_entity
    end
  end

  api :DELETE, '/v1/users/sign_out', 'Sign out user'
  param_group :authentication
  def sign_out
    user = User.find(params[:user_id])
    user.auth_token = nil

    if user.save
      render json: { success: 'Anda berhasil keluar.' }, status: :ok
    else
      render json: { error: 'Kamu sudah log out.' }, status: :unprocessable_entity
    end
  end

  api :POST, '/v1/users/register', 'Register user'
  param_group :user
  def register
    user = User.new(user_params)

    if user.save
      render json: { success: "Kami telah mengirimkan email konfirmasi. Silakan lihat email anda untuk instruksi lebih lanjut." }, status: :created
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  api :GET, '/v1/users/:user_id', "Get user's detail"
  param :user_id, String
  def show
  end

  api :PUT, '/v1/users/:user_id', "Update user"
  param_group :user_update
  def update
    @user.update(user_update_params)

    if @user.save
      render json: { success: 'Profil anda berhasil diupdate.' }, status: :ok
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :username)
    end

    def user_update_params
      params.require(:user).permit(:email, :first_name, :last_name, :neighborhood, :address, :gender, :birthday, :handphone, :status, :country, :city, :province, :username)
    end

    def verify_user
      unless User.find_by(auth_token: params[:auth_token], id: params[:user_id])
        render json: { error: "You don't have access." }
      end
    end
end
