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
  has_many :messages
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :language, :name , presence: true 
  
  validates_uniqueness_of :name,  message: "Already Exists"
end
