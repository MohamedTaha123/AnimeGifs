require 'rails_helper'

RSpec.describe Follow, type: :model do
  describe '#new' do
    it 'should not pass without follower' do
      expect(FactoryGirl.build(:follow, follower_id: nil)).to_not be_valid
    end
    it 'should not pass without followable' do
      expect(FactoryGirl.build(:follow, followable_id: nil)).to_not be_valid
    end
  end
end
