class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @reviews = Gif.where(user_id: current_user.id).pluck(:impressions_count).sum(&:to_i)
    @followers = current_user.followers.count

    @user_repos = current_user.user_repos
  end
end
