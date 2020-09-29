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

require "rails_helper"

RSpec.describe Gif, type: :model do
  describe "#new" do
    it "new instance" do
      expect(FactoryBot.build(:gif, user_id: nil)).not_to be_valid
    end

    it "does not pass without user id" do
      expect(FactoryBot.build(:gif, user_id: nil)).not_to be_valid
    end

    it "does not pass without description" do
      expect(FactoryBot.build(:gif, description: nil)).not_to be_valid
    end

    it "does not pass without label" do
      expect(FactoryBot.build(:gif, label: nil)).not_to be_valid
    end

    it "does not pass with too short description" do
      expect(FactoryBot.build(:gif, description: "a")).not_to be_valid
    end

    it "does not pass with too long description" do
      expect(FactoryBot.build(:gif, description: Faker::Lorem.characters(number: 51))).not_to be_valid
    end

    it "has tag_list" do
      expect(FactoryBot.build(:gif, tag_list: "")).not_to be_valid
    end

    it "does not pass without image" do
      expect(FactoryBot.build(:gif, image: nil)).not_to be_valid
    end

    it "does not pass without languauge" do
      @gif = FactoryBot.build(:gif, language: "")
      expect(@gif).not_to be_valid
    end
  end

  describe "#user" do
    it "returns the user who created the gif" do
      expect(subject).to belong_to(:user)
    end
  end

  describe "#tags" do
    it "returns the tags related to gif" do
      expect(subject).to have_many(:tags)
    end
  end

  describe "#relations" do
    it { is_expected.to have_many(:comments) }
  end
end
