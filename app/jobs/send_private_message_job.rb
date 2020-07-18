class SendPrivateMessageJob < ApplicationJob
  queue_as :default

  def perform(chat)
    mine = ApplicationController.render(
      partial: 'chats/mine',
      locals: { chat: chat }
    )

    theirs = ApplicationController.render(
      partial: 'chats/theirs',
      locals: { chat: chat }
    )

    ActionCable.server.broadcast "chatroom_channel_#{chat.conversation_id}", mine: mine, theirs: theirs, content: chat
  end
end
