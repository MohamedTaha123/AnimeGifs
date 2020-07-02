# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id          :bigint           not null, primary key
#  attachement :string
#  content     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  chatroom_id :integer
#  user_id     :integer
#

FactoryBot.define do
  factory :message do
    content { 'MyString' }
  end
end
