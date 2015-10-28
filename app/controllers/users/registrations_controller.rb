class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update]

  def new
    session["devise.omniauth"] ||= {}
    build_resource(session["devise.omniauth"])
    
    set_minimum_password_length
    yield resource if block_given?
    respond_with self.resource
  end

  def create
    build_resource(sign_up_params)
    resource.create_from_omniauth(session["devise.omniauth"])
    
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
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

    def after_update_path_for(resource)
      edit_user_registration_url
    end
end
