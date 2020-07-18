class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    chatt = Chat.find(params[:conversation_id])
    stream_for "chat_#{chatt}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
