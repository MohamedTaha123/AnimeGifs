# == Schema Information
#
# Table name: chatrooms
#
#  id         :bigint           not null, primary key
#  name       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_chatrooms_on_slug  (slug) UNIQUE
#

FactoryGirl.define do
  factory :chatroom do
    name "MyString"
  end
end
