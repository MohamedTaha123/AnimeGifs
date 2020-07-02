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

require 'rails_helper'

RSpec.describe Chatroom, type: :model do
  describe '#new' do
    it 'should not pass without a name' do
      expect(FactoryBot.build(:chatroom, name: nil)).to_not be_valid 
    end
    it 'should not pass without language' do
      expect(FactoryBot.build(:chatroom, language: nil)).to_not be_valid
    end
    
    it { should validate_uniqueness_of(:name).with_message('Already Exists') }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:language) }
    it { should have_many(:messages) } 
  end
end
