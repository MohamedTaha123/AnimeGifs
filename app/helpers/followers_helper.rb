# frozen_string_literal: true

module FollowersHelper
  def follow_button_for_v2(gif)
    if current_user.nil?
      button_to follow_gif_follower_path(gif, gif.user), method: :put, class: 'btn btn-info btn-sm' do
        'Follow'
      end
    else
      if current_user.following?(gif.user)
        button_to unfollow_gif_follower_path(gif, gif.user), method: :put, class: 'btn btn-info btn-sm', remote: true do
          'Followed'
        end
      else
        button_to follow_gif_follower_path(gif, gif.user), method: :put, class: 'btn btn-info btn-sm', remote: true do
          'Follow'
        end
      end
    end
  end
end
