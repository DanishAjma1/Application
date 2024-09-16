class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  include Pagy::Backend
  allow_browser versions: :modern
  rescue_from CanCan::AccessDenied do |exception|
    # Customize the flash message
    flash[:alert] = "You are not Authorized User."

    # Redirect the user to a safe page, e.g., root_path or another relevant page
    redirect_to root_path
  end

  protect_from_forgery with: :exception, prepend: true
  before_action :authenticate_user!
  def after_sign_in_path_for(resource)
      projects_path # Redirect to the dashboard after sign-in
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path # Redirect to the homepage after sign-out
  end
end
