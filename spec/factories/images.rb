# == Schema Information
#
# Table name: images
#
#  id          :bigint           not null, primary key
#  description :string
#  images_hash :string
#  label       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  gif_id      :string
#

FactoryGirl.define do
  factory :image do
    images_hash "MyString"
    label "MyString"
    description "MyString"
    gif_id "MyString"
  end
end
