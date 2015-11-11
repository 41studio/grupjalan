class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :redirect_https

  def redirect_https        
    redirect_to :protocol => "https://" unless request.ssl?
    return true              
  end

  def authenticate_admin!
  	redirect_to new_user_session_path unless current_user.try(:is_admin?)
  end
end
  