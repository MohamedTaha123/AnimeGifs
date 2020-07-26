# frozen_string_literal: true

class ConversationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.where.not(id: current_user.id)
    # @conversations = Conversation.where('sender_id = ? OR recipient_id = ?', current_user.id, current_user.id).includes([:sender]).includes([:recipient])
    @conversations = Conversation.where('sender_id = ? OR recipient_id = ?', current_user.id, current_user.id).includes([:recipient, :sender])
  end

  def create
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    redirect_to new_conversation_chat_path(@conversation)
  end

  private

  def conversation_params
    params.require(:conversation).permit(:sender_id, :recipient_id)
  end
end
