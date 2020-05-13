# frozen_string_literal: true

require 'faker'
FactoryGirl.define do
  factory :gif do
    description { Faker::Lorem.sentence }
    label { Faker::Lorem.sentence }
    user_id { Faker::Number.between(0, 1024) }
    # user_id { create :user}
    tag_list { %w[ruby js scss] }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/giphy.gif')) }
    language { Faker::Lorem.sentence }
  end
end
