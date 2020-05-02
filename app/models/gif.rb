# frozen_string_literal: true

class Gif < ApplicationRecord
  belongs_to :user
  has_rich_text :description
  mount_uploader :image, ImageUploader, mount_on: :image
  validates_integrity_of :image
  validates_processing_of :image
  validates_presence_of :image
  validates_size_of :image, maximum: 1.megabytes, message: "should be less than 1MB"

  validates :label, :description, presence: true
  validates :description, length: { minimum: 15 }

  
end
