class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    if request.format.json?
      render json: { error: 'Kamu tidak punya akses.' }
    else
      redirect_to root_url, :alert => exception.message
    end
  end

  if Rails.env.production?
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActionController::RoutingError, with: :render_not_found
  end

  def render_not_found
    if request.format.json?
      render json: { errors: 'Data tidak ditemukan.' }, status: 404
    else
      render file: 'public/404', layout: false
    end
  end

  def authenticate_admin!
  	redirect_to new_user_session_path unless current_user.try(:is_admin?)
  end

  def find_resource
    resource_class.is_a?(FriendlyId) ? scoped_collection.where(slug: params[:id]).first! : scoped_collection.where(id: params[:id]).first!
  end
end
