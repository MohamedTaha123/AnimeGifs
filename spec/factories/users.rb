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
#  last_seen_at               :datetime
#  little_description         :string
#  remember_created_at        :datetime
#  repos_hash                 :text
#  reset_password_sent_at     :datetime
#  reset_password_token       :string
#  username                   :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'faker'
FactoryGirl.define do
  factory :user do
    name { Faker::Internet.user_name(4..20).gsub(/[.]/, '') }
    email { Faker::Internet.email }
    password { Faker::Internet.password(8, 20) }
    facebook_url { 'https://facebook.com/test' }
    github_url { 'https://github.com/test' }
    little_description { Faker::Lorem.sentence }
  end
end
