# frozen_string_literal: true

class ChatroomController < ApplicationController
  before_action :authenticate_user!
  def show
    @chatroom = Chatroom.friendly.find(params[:id])
    @message = Message.new
    @new_chatroom = Chatroom.new
  end

  def new
    @chatroom = Chatroom.new
  end

  def create
    @chatroom = Chatroom.create(chatroom_params)
    respond_to do |format|
      if @chatroom.save
        format.html { redirect_to chatroom_path(@chatroom), success: "Room Created" }
      else
        format.html { redirect_to new_chatroom_path, alert: "Can\'t Create a Room" }
        format.json { render json: @chatroom.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def chatroom_params
    params.require(:chatroom).permit(:language, :name)
  end
end
