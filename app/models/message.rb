# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id          :bigint           not null, primary key
#  attachement :string
#  content     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  chatroom_id :integer
#  user_id     :integer
#

class Message < ApplicationRecord
  before_create :randomize_id
  belongs_to :user
  belongs_to :chatroom
  mount_uploader :attachement, AttachementUploader
  validates_presence_of :content, unless: -> { attachement.blank? }
  accepts_nested_attributes_for :user
  acts_as_readable on: :created_at
  validates_length_of :content, within: 10..500, on: :create
  # Randomize Id
  def randomize_id
    begin
      self.id = SecureRandom.random_number(1_000_000)
    end while Message.where(id: id).exists?
  end
end
