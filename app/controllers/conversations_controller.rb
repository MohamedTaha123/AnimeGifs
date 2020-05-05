# frozen_string_literal: true

class ConversationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @conversations = Conversation.where(recipient_id: current_user.id).or(Conversation.where(sender_id: current_user.id))
  end

  def show; end
end
