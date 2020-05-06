# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                         :integer          not null, primary key
#  admin                      :boolean          default(FALSE)
#  announcements_last_read_at :datetime
#  email                      :string           default(""), not null
#  encrypted_password         :string           default(""), not null
#  facebook_url               :string
#  first_name                 :string
#  github_url                 :string
#  last_name                  :string
#  little_description         :string
#  provider                   :string
#  remember_created_at        :datetime
#  reset_password_sent_at     :datetime
#  reset_password_token       :string
#  uid                        :string
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

  devise :masqueradable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:github]
  has_rich_text :little_description
  has_person_name
  acts_as_voter
  acts_as_followable
  acts_as_follower

  has_many :notifications, foreign_key: :recipient_id
  has_many :services
  has_many :gifs, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, 'valid_email_2/email': true
  validates :github_url, on: :update, length: { maximum: 100 }, format: GITHUB_URL_REGEXP
  validates :facebook_url, on: :update, length: { maximum: 100 }, format: FACEBOOK_URL_REGEXP
  validates_uniqueness_of :github_url, on: :update, allow_blank: true, message: 'Already Taken'
  validates_uniqueness_of :facebook_url, on: :update, allow_blank: true, message: 'Already Taken'

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.email = auth.info.email
      user.uid = auth.uid
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
    end
  end

  # Update with password
  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end
