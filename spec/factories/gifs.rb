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
