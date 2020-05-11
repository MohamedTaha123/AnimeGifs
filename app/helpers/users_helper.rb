# frozen_string_literal: true

module UsersHelper
  include GravatarImageTag
  def avatar_url(user, size)
    if gravatar_image_url(user.email).present?
      gravatar_image_url(user.email, size: size)
    else
      Avatarly.generate_avatar(user.name, opts = { size: size, font_color: '#ffffff' })
    end
  end

  def avatarly_url(user, size)
    Base64.strict_encode64(Avatarly.generate_avatar(user.name, opts = { size: size, font_color: '#ffffff' }))
  end

  def github_avatar_url(user, _size)
    user.avatar if user.avatar.present?
  end
end
