# frozen_string_literal: true

FactoryGirl.define do
  factory :follow do |f|
    f.follower_id 1
    f.followable_id 2
    f.followable_type 'User'
    f.follower_type 'User'
  end
end
