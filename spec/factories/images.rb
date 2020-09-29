# frozen_string_literal: true

# == Schema Information
#
# Table name: images
#
#  id          :bigint           not null, primary key
#  description :string
#  images_hash :json
#  label       :string
#  tag_list    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  gif_id      :string
#

FactoryBot.define do
  factory :image do
    images_hash { "MyString" }
    label { "MyString" }
    description { "MyString" }
    gif_id { 1222 }
  end
end
