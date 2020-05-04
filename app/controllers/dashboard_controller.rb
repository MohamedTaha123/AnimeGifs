class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @reviews = Gif.where(user_id: current_user.id).pluck(:impressions_count).sum
    @followers = current_user.followers.count
  end
end
