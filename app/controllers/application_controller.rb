# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :masquerade_user!
  before_action :set_notifications, if: :user_signed_in?
  before_action :set_last_seen_at, if: :user_signed_in?
  before_action  :configure_permitted_parameters, if: :devise_controller?
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:accept_invitation, keys: %i[name avatar])
  end

  def set_notifications
    @notifications = Notification.where(recipient: current_user).recent
  end

  def set_last_seen_at
    current_user.touch(:last_seen_at)
  end
end
