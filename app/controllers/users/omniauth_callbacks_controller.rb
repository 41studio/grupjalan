class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
   def callback_omniauth
    auth = request.env["omniauth.auth"].except(:extra)
    @user = User.from_omniauth(auth)

    if @user.new_record?
      session["devise.omniauth"] = @user.attributes
      redirect_to new_user_registration_url
    else
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => auth.provider.capitalize) if is_navigational_format?
    end
  end

  # alias_method :twitter, :callback_omniauth
  alias_method :facebook, :callback_omniauth
  alias_method :google_oauth2, :callback_omniauth
end
