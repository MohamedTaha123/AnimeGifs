class BroadcastToRoomJob < ApplicationJob
  queue_as :default

  def perform(message)
    # Perform Broadcasting message to Room
    ChatroomChannel.broadcast_to(
      message.chatroom,
      ApplicationController.new.render_to_string(partial: "messages/message", locals: { message: message }),
    )
  rescue StandardError => e 
  	puts e.to_s
  end
end
