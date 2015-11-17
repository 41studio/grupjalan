class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :redirect_https

  # def redirect_https        
  #   redirect_to :protocol => "https://" unless request.ssl?
  #   return true              
  # end

  rescue_from CanCan::AccessDenied do |exception|
    if request.format.json?
      render json: { error: 'Kamu tidak punya akses.' }
    else
      redirect_to root_url, :alert => exception.message
    end
  end

  def authenticate_admin!
  	redirect_to new_user_session_path unless current_user.try(:is_admin?)
  end

  def find_resource
    resource_class.is_a?(FriendlyId) ? scoped_collection.where(slug: params[:id]).first! : scoped_collection.where(id: params[:id]).first!
  end
end
