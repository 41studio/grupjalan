class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update]
  after_action :clear_session, only: [:new, :create]

  def new
    session["devise.omniauth"] ||= {}
    build_resource(session["devise.omniauth"])
    
    set_minimum_password_length
    yield resource if block_given?
    respond_with self.resource
  end

  protected

    def configure_sign_up_params
      devise_parameter_sanitizer.for(:sign_up) << [:photo, :video, :username, :first_name, :last_name, :neighborhood, :address, :gender, :brithday, :handphone, :status, :role, :country, :city, :province]
    end

    def configure_account_update_params
      devise_parameter_sanitizer.for(:account_update) << [:photo, :video, :username, :first_name, :last_name, :neighborhood, :address, :gender, :brithday, :handphone, :status, :role, :country, :city, :province]
    end

    def clear_session
      session["devise.omniauth"] = nil
    end
end
