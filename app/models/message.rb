# == Schema Information
#
# Table name: messages
#
#  id          :bigint           not null, primary key
#  content     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  chatroom_id :integer
#  user_id     :integer
#

class Message < ApplicationRecord
    belongs_to :user 
    belongs_to :chatroom
    validates_presence_of :content, on: :create
end
