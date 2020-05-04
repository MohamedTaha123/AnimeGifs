# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications
  end

  def mark_as_read
    @notification = Notification.find(
      params[:id]
    )
    @notification.update(read_at: Time.now)
    respond_to do |format|
      format.html { redirect_to request.referer, alert: 'Marked As Read' }
    end
  end
end
