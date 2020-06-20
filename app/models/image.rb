# frozen_string_literal: true

# == Schema Information
#
# Table name: images
#
#  id          :bigint           not null, primary key
#  description :string
#  images_hash :json
#  label       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  gif_id      :string
#

class Image < ApplicationRecord
  before_create :randomize_id
  # has_many_attached :images_hash
  mount_uploaders :images_hash, ImagesHashUploader
  validates :images_hash, presence: true

  def randomize_id
    begin
      self.gif_id = SecureRandom.random_number(1_000_000)
    end while Image.where(gif_id: gif_id).exists?
  end
end
