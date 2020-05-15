# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                         :bigint           not null, primary key
#  admin                      :boolean          default(FALSE)
#  announcements_last_read_at :datetime
#  avatar                     :string
#  deleted_at                 :datetime
#  email                      :string           default(""), not null
#  encrypted_password         :string           default(""), not null
#  facebook_url               :string
#  first_name                 :string
#  github_url                 :string
#  last_name                  :string
#  little_description         :string
#  remember_created_at        :datetime
#  reset_password_sent_at     :datetime
#  reset_password_token       :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  GITHUB_URL_REGEXP = %r{\A(http(s)?://)?(www.github.com|github.com)/.*\z}.freeze
  FACEBOOK_URL_REGEXP = %r{\A(http(s)?://)?(www.facebook.com|facebook.com)/.*\z}.freeze

  devise :masqueradable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable
  has_rich_text :little_description
  # mount_uploader :avatar, ImageUploader
  has_person_name
  acts_as_voter
  acts_as_followable
  acts_as_follower

  has_many :gifs, dependent: :destroy
  has_many :notifications, foreign_key: :recipient_id
  has_many :services, dependent: :destroy
  has_many :messages

  validates :name, presence: true
  validates :email, presence: true, 'valid_email_2/email': true
  validates :github_url, presence: false, on: :update, length: { maximum: 100 }, format: GITHUB_URL_REGEXP, allow_blank: true
  validates :facebook_url, presence: false, on: :update, length: { maximum: 100 }, format: FACEBOOK_URL_REGEXP, allow_blank: true
  validates :github_url, uniqueness: { scope: :id }
  validates :facebook_url, uniqueness: { scope: :id }
  validates_presence_of :little_description, on: :update
 
 

  # alternative callback for omniauth
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
    end
  end

  # instead of deleting, indicate the user requested a delete & timestamp it
  def soft_delete
    update_attribute(:deleted_at, Time.current)
  end

  # ensure user account is active
  def active_for_authentication?
    super && !deleted_at
  end

  # provide a custom message for a deleted account
  def inactive_message
    !deleted_at ? super : :deleted_account
  end
end
