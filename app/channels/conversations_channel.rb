# frozen_string_literal: true

class ConversationsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "current_user_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    # stop_all_streams
  end
end
