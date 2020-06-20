# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!
  def create
    @chatroom = Chatroom.friendly.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user
    if @message.save
      ChatroomChannel.broadcast_to(@chatroom, render_to_string(partial: 'message', locals: { message: @message }))
      redirect_to chatroom_path(@chatroom, anchor: "message-#{@message.id}")
    else
      redirect_to chatroom_path(@chatroom)

    end
  end

  def remove
    @chatroom = Chatroom.friendly.find(
      params[:chatroom_id]
    )
    @message = Message.find(params[:id])
    @message.destroy
    respond_to do |format|
      format.html { redirect_to chatroom_path(@chatroom, anchor: "message-#{@chatroom.messages.last.id}") }
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
