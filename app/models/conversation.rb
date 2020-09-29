# frozen_string_literal: true

# == Schema Information
#
# Table name: conversations
#
#  id           :bigint           not null, primary key
#  slug         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :integer
#  sender_id    :integer
#
# Indexes
#
#  index_conversations_on_slug  (slug) UNIQUE
#

class Conversation < ApplicationRecord
  has_many :chats, dependent: :destroy
  belongs_to :sender, foreign_key: :sender_id, class_name: "User"
  belongs_to :recipient, foreign_key: :recipient_id, class_name: "User"
  validates :sender_id, uniqueness: { scope: :recipient_id }

  scope :between, lambda { |sender_id, recipient_id|
    where(sender_id: sender_id, recipient_id: recipient_id).or(
      where(sender_id: recipient_id, recipient_id: sender_id),
    )
  }

  def self.get(sender_id, recipient_id)
    conversation = between(sender_id, recipient_id).first
    return conversation if conversation.present?

    create(sender_id: sender_id, recipient_id: recipient_id)
  end

  def opposed_user(user)
    user == recipient ? sender : recipient
  end
end
