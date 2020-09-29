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
#  invitation_accepted_at     :datetime
#  invitation_created_at      :datetime
#  invitation_limit           :integer
#  invitation_sent_at         :datetime
#  invitation_token           :string
#  invitations_count          :integer          default(0)
#  invited_by_type            :string
#  last_name                  :string
#  last_seen_at               :datetime
#  little_description         :string
#  remember_created_at        :datetime
#  repos_hash                 :text
#  reset_password_sent_at     :datetime
#  reset_password_token       :string
#  session_token              :string
#  username                   :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  invited_by_id              :bigint
#
# Indexes
#
#  index_users_on_email                              (email) UNIQUE
#  index_users_on_invitation_token                   (invitation_token) UNIQUE
#  index_users_on_invitations_count                  (invitations_count)
#  index_users_on_invited_by_id                      (invited_by_id)
#  index_users_on_invited_by_type_and_invited_by_id  (invited_by_type,invited_by_id)
#  index_users_on_reset_password_token               (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :invitable, :masqueradable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:github]
  has_rich_text :little_description

  after_invitation_accepted :process_find_repos_and_assign_job
  after_create :process_find_repos_and_assign_job
  GITHUB_URL_REGEXP = %r{\A(http(s)?://)?(www.github.com|github.com)/.*\z}.freeze
  FACEBOOK_URL_REGEXP = %r{\A(http(s)?://)?(www.facebook.com|facebook.com)/.*\z}.freeze
  # mount_uploader :avatar, ImageUploader
  has_person_name
  acts_as_voter
  acts_as_followable
  acts_as_follower
  acts_as_reader
  serialize :repos_hash, JSON

  has_many :gifs, dependent: :destroy
  has_many :notifications, foreign_key: :recipient_id
  has_many :services, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :invitations, class_name: to_s, as: :invited_by
  validates :name, presence: true
  validates :email, presence: true, 'valid_email_2/email': true
  validates :github_url, presence: false, on: :update, length: { maximum: 100 }, format: GITHUB_URL_REGEXP, allow_blank: true
  validates :facebook_url, presence: false, on: :update, length: { maximum: 100 }, format: FACEBOOK_URL_REGEXP, allow_blank: true
  validates :github_url, uniqueness: { scope: :id }
  validates :facebook_url, uniqueness: { scope: :id }
  # validates_presence_of :little_description, on: :update

  # alternative callback for omniauth- Not Using IT NOW
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.login
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

  def online?
    last_seen_at > 15.minutes.ago
  end

  # Fix Session Storage(Cookies)
  def authenticatable_salt
    "#{super}#{session_token}"
  end

  def invalidate_all_sessions!
    update_attribute(:session_token, SecureRandom.hex)
  end

  # Get User Repos Scope
  def user_repos
    repos_hash.map do |repo|
      repo
    end
  end

  def process_find_repos_and_assign_job
    FindReposAndAssignJob.perform_now(self)
  end

  # User followers
  def user_followers
    Rails.cache.fetch([cache_key, __method__], expires_in: 30.minutes) do
      return 0 if followers.blank?

      followers.pluck(:id).count
    end
  end
end
