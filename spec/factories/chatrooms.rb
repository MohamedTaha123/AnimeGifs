# frozen_string_literal: true

# == Schema Information
#
# Table name: chatrooms
#
#  id         :bigint           not null, primary key
#  language   :string
#  name       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_chatrooms_on_slug  (slug) UNIQUE
#

FactoryBot.define do
  factory :chatroom do
    # name 'MyString'
    # language 'ruby'
  end
end
