# frozen_string_literal: true

# == Schema Information
#
# Table name: gifs
#
#  id                :bigint           not null, primary key
#  description       :string
#  image             :string
#  impressions_count :integer
#  label             :string
#  language          :string
#  slug              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :bigint
#
# Indexes
#
#  index_gifs_on_slug     (slug) UNIQUE
#  index_gifs_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'file_size_validator' 

class Gif < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  before_create :default_name

  extend FriendlyId
  friendly_id :label, use: :slugged
  acts_as_votable
  acts_as_taggable
  is_impressionable counter_cache: true, column_name: :impressions_count

  mount_uploader :image, ImageUploader, mount_on: :image

  validates_integrity_of :image
  validates_processing_of :image

  validates :image, presence: true,  file_size: { maximum: 2.megabytes.to_i }

  validates :label, :description, presence: true
  validates :description, length: { minimum: 15, maximum: 200 }
  validates :tag_list, presence: true
  validate :has_at_least_one_tag

  def has_at_least_one_tag
    errors.add(:tag_list, "must have at least one tag") if tag_list.blank?
  end

  # validates :image_path, :presence => true

  def default_name
    self.image ||= File.basename(image.filename, ".*").titleize if image
  end
end
