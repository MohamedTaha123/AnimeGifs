# frozen_string_literal: true

module GifsHelper
  def likers_of(gif)
    votes = gif.votes_for.up.by_type(User)

    if votes.count < 4
      list_likers(votes)
    else
      recent_liker_and_count(votes)
    end
  end

  def like_button_for(gif)
    if current_user.nil?
      button_to like_gif_path(gif.id), method: :put, class: 'btn btn-sm btn-outline-white' do
        'Like'
      end
    else
      if current_user.voted_up_on? gif
        button_to unlike_gif_path(gif.id), method: :put, class: 'btn btn-sm btn-outline-white', remote: true do
          'Liked'
        end
      else
        button_to like_gif_path(gif.id), method: :put, class: 'btn btn-sm btn-outline-white', remote: true do
          'Like'
        end
      end
    end
  end

  def follow_button_for(gif)
    if current_user.nil?
      link_to follow_gif_path(gif, gif.user), method: :put, class: 'btn btn-info btn-sm' do
        'Follow'
      end
    else
      if current_user.following?(gif.user)
        link_to unfollow_gif_path(gif.user), method: :put, class: 'btn btn-info btn-sm', remote: true do
          'Followed'
        end
      else
        link_to follow_gif_path(gif.user), method: :put, class: 'btn btn-info btn-sm', remote: true do
          'Follow'
        end
      end
    end
  end


  private

  def list_likers(votes)
    likers = []
    votes.voters.each do |user|
      likers << user.name
    end

    if likers.count > 0
      likers.to_sentence.html_safe + pluralize_likes(likers.count)
    end
  end

  def recent_liker_and_count(votes)
    count = votes.voters.count
    recent_liker = votes.voters.first

    result = []
    result << recent_liker.name
    result << " #{count - 1} others like this"

    result.to_sentence.html_safe
  end

  def pluralize_likes(count)
    if count > 1
      ' like this'
    else
      ' likes this'
    end
  end
end
