# frozen_string_literal: true

class ChatRelayJob < ApplicationJob
  queue_as :default

  def perform(conv, current_user, content)
    ActionCable.server.broadcast "current_user_#{current_user.id}", content: content
    ActionCable.server.broadcast(
      # Broadcast to user/receiver private channel
      "current_user_#{conv.recipient_id}",
      content,
    )
  end
end
