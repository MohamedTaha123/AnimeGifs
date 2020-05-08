# frozen_string_literal: true

module GifsHelper
  def like_button_for(gif)
    if current_user.nil?
      button_to like_gif_path(gif.id), method: :put, class: 'btn btn-sm btn-danger' do
        'Like'
      end
    else
      if current_user.voted_up_on? gif
        button_to unlike_gif_path(gif.id), method: :put, class: 'btn btn-sm btn-danger', remote: true do
          'Liked'
        end
      else
        button_to like_gif_path(gif.id), method: :put, class: 'btn btn-sm btn-danger', remote: true do
          'Like'
        end
      end
    end
  end
end
