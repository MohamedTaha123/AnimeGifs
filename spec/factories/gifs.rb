require 'faker'
FactoryGirl.define do
  factory :gif do
    
    description { Faker::Lorem.sentence }
    label { Faker::Lorem.sentence }
    user_id { Faker::Number.between(0, 1024) }
  end
end
