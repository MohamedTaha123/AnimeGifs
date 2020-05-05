# frozen_string_literal: true

class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
  validates :message, presence: true
end
