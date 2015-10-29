class BaseApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user_from_token!

  private
    def authenticate_user_from_token!
      user = params[:auth_token].present? && User.find_by(auth_token: params[:auth_token])

      unless user && Devise.secure_compare(user.auth_token, params[:auth_token])
        render json: { error: "You don't have access." }, status: :upprocessable_entity
      end
    end
end