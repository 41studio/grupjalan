class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
   def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_facebook_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end


 def google_oauth2
    @user = User.from_google_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Google_oauth2") if is_navigational_format?
    else
      flash[:notice] = @user.errors.full_messages.to_sentence
      session["devise.google_oauth2_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end    
  end

  def twitter
    @user = User.from_twitter_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
    else
      flash[:notice] = @user.errors.full_messages.to_sentence
      session["devise.twitter_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end    
  end
end
