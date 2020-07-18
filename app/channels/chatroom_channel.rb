class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chatroom_channel_#{params[:conversation_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end
end
