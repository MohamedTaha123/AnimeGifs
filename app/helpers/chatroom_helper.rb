# frozen_string_literal: true

module ChatroomHelper
  def get_chat_room(user)
    if user.messages.present?
      user.messages.includes([:chatroom]).last.chatroom
    else
      Chatroom.order(Arel.sql("RANDOM()")).first
    end
  end
end
