# frozen_string_literal: true

class ChatroomController < ApplicationController
  before_action :authenticate_user!
  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end
end
