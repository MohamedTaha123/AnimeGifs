# frozen_string_literal: true

class FollowersController < ApplicationController
  before_action :authenticate_user!

  def follow
    @gif = Gif.friendly.find(
      params[:gif_id],
    )
    @user = @gif.user
    current_user.follow(@user)
    Notification.create(recipient: @user, actor: current_user, action: "follow", notifiable: @user)
    # ActionCable.server.broadcast('welcome_channel', "You Start Following #{@user.name}.")
    # ActionCable.server.broadcast('welcome_channel', "#{current_user.name} Start Following You.")
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  rescue StandardError => e
    puts e.to_s
  end

  def unfollow
    @gif = Gif.friendly.find(
      params[:gif_id],
    )
    @user = @gif.user
    current_user.stop_following(@user)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  rescue StandardError => e
    puts e.to_s
  end
end
