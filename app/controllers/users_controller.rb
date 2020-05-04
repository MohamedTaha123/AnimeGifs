# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  def follow
    @gif = Gif.find(params[:gif_id])
    @user = @gif.user
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to request.referer, alert: 'Followed' }
      format.json { head :no_content }
    end
  end

  def unfollow
    @gif = Gif.find(params[:gif_id])
    @user = @gif.user
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to request.referer, alert: 'Unfollowed' }
      format.json { head :no_content }
    end
  end
end
