# frozen_string_literal: true
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
