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
  FACEBOOK_URL_REGEXP = /\A(http(s)?:\/\/)?(www.facebook.com|facebook.com)\/.*\z/.freeze

  devise :masqueradable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable
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
  validates :github_url, length: { maximum: 100 }, allow_blank: true, format: GITHUB_URL_REGEXP
  validates :facebook_url, length: { maximum: 100 }, allow_blank: true, format: FACEBOOK_URL_REGEXP

end
