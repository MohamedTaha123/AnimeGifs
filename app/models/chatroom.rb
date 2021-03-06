# frozen_string_literal: true

# == Schema Information
#
# Table name: chatrooms
#
#  id         :bigint           not null, primary key
#  language   :string
#  name       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_chatrooms_on_slug  (slug) UNIQUE
#

class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :language, :name, presence: true

  validates :name, uniqueness: { message: "Already Exists" }
end
