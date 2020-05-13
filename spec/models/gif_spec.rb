# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Gif, type: :model do
  describe '#new' do
    it 'new instance' do
      expect(FactoryGirl.build(:gif, user_id: nil)).to_not be_valid
    end
    it 'should not pass without user id' do
      expect(FactoryGirl.build(:gif, user_id: nil)).to_not be_valid
    end
    it 'should not pass without description' do
      expect(FactoryGirl.build(:gif, description: nil)).to_not be_valid
    end
    it 'should not pass without label' do
      expect(FactoryGirl.build(:gif, label: nil)).to_not be_valid
    end
    it 'should not pass with too short description' do
      expect(FactoryGirl.build(:gif, description: 'a')).to_not be_valid
    end
    it 'should not pass with too long description' do
      expect(FactoryGirl.build(:gif, description: Faker::Lorem.characters(51))).to_not be_valid
    end
  end
  describe '#user' do
    it 'should return the user who created the gif' do
      is_expected.to belong_to(:user)
    end
  end
end
