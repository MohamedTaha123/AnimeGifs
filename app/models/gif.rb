# frozen_string_literal: true

# == Schema Information
#
# Table name: gifs
#
#  id                :integer          not null, primary key
#  description       :string
#  image             :string
#  impressions_count :integer
#  label             :string
#  slug              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer
#
# Indexes
#
#  index_gifs_on_slug  (slug) UNIQUE
#

class Gif < ApplicationRecord
  belongs_to :user
  extend FriendlyId
  friendly_id :label, use: :slugged
  acts_as_votable
  acts_as_taggable
  is_impressionable counter_cache: true, column_name: :impressions_count
  include PublicActivity::Model
  tracked owner: proc { |controller, _model| controller.current_user }
  mount_uploader :image, ImageUploader, mount_on: :image
  validates_integrity_of :image
  validates_processing_of :image
  validates_presence_of :image
  validates_size_of :image, maximum: 2.megabytes, message: 'should be less than 2MB'

  validates :label, :description, presence: true
  validates :description, length: { minimum: 15 }
  validate :has_at_least_one_tag

  def has_at_least_one_tag
    errors.add(:tag_list, 'must have at least one tag') unless tag_list.present?
  end
end
