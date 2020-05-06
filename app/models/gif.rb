# frozen_string_literal: true

# == Schema Information
#
# Table name: gifs
#
#  id                :integer          not null, primary key
#  image             :string
#  description       :string
#  label             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer
#  slug              :string
#  impressions_count :integer
#


class Gif < ApplicationRecord
  belongs_to :user
  extend FriendlyId
  friendly_id :label, use: :slugged
  acts_as_votable
  is_impressionable counter_cache: true, column_name: :impressions_count
  include PublicActivity::Model
  tracked owner: proc { |controller, _model| controller.current_user }
  mount_uploader :image, ImageUploader, mount_on: :image
  validates_integrity_of :image
  validates_processing_of :image
  validates_presence_of :image
  validates_size_of :image, maximum: 1.megabytes, message: 'should be less than 1MB'

  validates :label, :description, presence: true
  validates :description, length: { minimum: 15 }
end
