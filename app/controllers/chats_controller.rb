# frozen_string_literal: true

class ChatsController < ApplicationController
  before_action :set_chat, only: %i[show edit update destroy]
  before_action :set_conversation
  before_action :authenticate_user!
  # GET /chats
  # GET /chats.json
  def index
    @conversation = Conversation.find(
      params[:conversation_id],
    )
    @chats = @conversation.chats.all
  end

  # GET /chats/1
  # GET /chats/1.json
  def show; end

  # GET /chats/new
  def new
    @conversations = Conversation.where("sender_id = ? OR recipient_id = ?", current_user.id, current_user.id).includes([:recipient])

    @chats = @conversation.chats.order("created_at ASC")
    @chat = @conversation.chats.new
    @chat.conversation_id = @conversation.id
  end

  # GET /chats/1/edit
  def edit; end

  # POST /chats
  # POST /chats.json
  def create
    @chat = @conversation.chats.new(chat_params)
    @chat.user = current_user
    respond_to do |format|
      if @chat.save
        SendPrivateMessageJob.perform_later(@chat)
        format.html { redirect_to new_conversation_chat_path(@conversation) }
        # format.js

      else
        format.html { render :new }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chats/1
  # PATCH/PUT /chats/1.json
  def update
    respond_to do |format|
      if @chat.update(chat_params)
        format.html { redirect_to @chat, notice: "Chat was successfully updated." }
        format.json { render :show, status: :ok, location: @chat }
      else
        format.html { render :edit }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chats/1
  # DELETE /chats/1.json
  def destroy
    @chat.destroy
    respond_to do |format|
      format.html { redirect_to chats_url, notice: "Chat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_chat
    @chat = Chat.find(params[:id])
  end

  def set_conversation
    @conversation = Conversation.find(
      params[:conversation_id],
    )
  end

  # Only allow a list of trusted parameters through.
  def chat_params
    params.require(:chat).permit(:message, :conversation_id)
  end
end
