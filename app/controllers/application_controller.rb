# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :masquerade_user!
  before_action :set_notifications, if: :user_signed_in?
  before_action :set_last_seen_at , if: :user_signed_in?
  

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name little_description github_url facebook_url avatar])
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name, :avatar])
  end

  def set_notifications
    @notifications = Notification.where(recipient: current_user).recent
  end
  
  def set_last_seen_at 
    current_user.touch(:last_seen_at)
  end
end
