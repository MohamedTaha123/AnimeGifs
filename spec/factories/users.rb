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

require "faker"
FactoryBot.define do
  factory :user do
    name { Faker::Internet.user_name(4..20).gsub(/[.]/, "") }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8, max_length: 20) }
    facebook_url { "https://facebook.com/test" }
    github_url { "https://github.com/test" }
    little_description { Faker::Lorem.sentence }
  end
end
