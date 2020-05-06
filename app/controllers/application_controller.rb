# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :masquerade_user!
  before_action :set_notifications, if: :user_signed_in?
  include PublicActivity::StoreController

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name little_description github_url facebook_url])
  end

  def set_notifications
    @notifications = Notification.where(recipient: current_user).recent
  end
end
