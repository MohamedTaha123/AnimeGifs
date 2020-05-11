# frozen_string_literal: true

# == Schema Information
#
# Table name: chats
#
#  id              :bigint           not null, primary key
#  message         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  conversation_id :integer
#  user_id         :integer
#


class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
  validates :message, :conversation_id, :user_id, presence: true

  
  def chat_time
    created_at.strftime("%d/%m/%y at %l:%M %p")
  end
end
