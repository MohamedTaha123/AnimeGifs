# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#new' do
    it 'returns a new instance of user' do
      expect(FactoryGirl.create(:user)).to be_valid
    end
    it 'is invalid without a name' do
      expect(FactoryGirl.build(:user, name: nil)).to_not be_valid
    end
    it 'is invalid without an email' do
      expect(FactoryGirl.build(:user, email: nil)).to_not be_valid
    end
    it 'is invalid without a password' do
      expect(FactoryGirl.build(:user, password: nil)).to_not be_valid
    end
    it 'is invalid if email format is wrong' do
      expect(FactoryGirl.build(:user, email: 'testemail')).to_not be_valid
    end
    it { should allow_value('https://github.com/test').for(:github_url) }
    it { should allow_value('https://facobook.com/test').for(:facebook_url) }
  
  end
  describe '#uniqueness' do
    it { should validate_uniqueness_of(:facebook_url).scoped_to(:id) }
    it { should validate_uniqueness_of(:github_url).scoped_to(:id) }
  end
  describe '#presence' do
    it { should validate_presence_of(:little_description).on(:update) }
  end
  describe '#follow' do
    it 'should return true if follow other user' do
      subject_user = FactoryGirl.create(:user)
      other_user = FactoryGirl.create(:user)
      Follow.create(following_id: subject_user.id, follower_id: other_user.id)

      expect(subject_user.follows?(other_user)).to be_falsey
    end
  end
end
