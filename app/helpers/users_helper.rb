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
    if user.avatar.present?
      user.avatar
    else
      Base64.strict_encode64(Avatarly.generate_avatar(user.name, opts = { size: size, font_color: '#ffffff' }))
    end
  end
end
