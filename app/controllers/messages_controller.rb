# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!
  def create
    @chatroom = Chatroom.friendly.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user_id = current_user.id
    if @message.save
      BroadcastToRoomJob.perform_later(@message)
      # redirect_to chatroom_path(@message.chatroom, anchor: "message-#{@message.id}")
      redirect_to chatroom_path(@message.chatroom, anchor: "message-#{@message.id}")

    else
      redirect_to chatroom_path(@chatroom)
    end
    # Start BroadcastToRoomJob
  end

  def remove
    @chatroom = Chatroom.friendly.find(
      params[:chatroom_id],
    )
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html do
        redirect_to chatroom_path(@chatroom,
                                  anchor: "message-#{@message.id}"), alert: "Deleted"
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :attachement)
  end
end
