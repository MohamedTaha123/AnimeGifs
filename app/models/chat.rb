# frozen_string_literal: true

class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
  validates :message, :conversation_id, :user_id, presence: true

  
  def chat_time
    created_at.strftime("%d/%m/%y at %l:%M %p")
  end
end
