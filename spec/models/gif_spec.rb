# frozen_string_literal: true

# == Schema Information
#
# Table name: gifs
#
#  id                :bigint           not null, primary key
#  description       :string
#  image             :string
#  impressions_count :integer
#  label             :string
#  language          :string
#  slug              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :bigint
#
# Indexes
#
#  index_gifs_on_slug     (slug) UNIQUE
#  index_gifs_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#


require 'rails_helper'

RSpec.describe Gif, type: :model do
  describe '#new' do
    it 'new instance' do
      expect(FactoryBot.build(:gif, user_id: nil)).to_not be_valid
    end
    it 'should not pass without user id' do
      expect(FactoryBot.build(:gif, user_id: nil)).to_not be_valid
    end
    it 'should not pass without description' do
      expect(FactoryBot.build(:gif, description: nil)).to_not be_valid
    end
    it 'should not pass without label' do
      expect(FactoryBot.build(:gif, label: nil)).to_not be_valid
    end
    it 'should not pass with too short description' do
      expect(FactoryBot.build(:gif, description: 'a')).to_not be_valid
    end
    it 'should not pass with too long description' do
      expect(FactoryBot.build(:gif, description: Faker::Lorem.characters(51))).to_not be_valid
    end
    it 'should have tag_list' do
      expect(FactoryBot.build(:gif, tag_list: '')).to_not be_valid
    end
    it 'should not pass without image' do
      expect(FactoryBot.build(:gif, image: nil)).to_not be_valid
    end
    it 'should not pass without languauge' do
      @gif = FactoryBot.build(:gif, language: '')
      expect(@gif).to_not be_valid
    end
  end
  describe '#user' do
    it 'should return the user who created the gif' do
      is_expected.to belong_to(:user)
    end
  end
  describe '#tags' do
    it 'should return the tags related to gif' do
      is_expected.to have_many(:tags)
    end
  end
end
