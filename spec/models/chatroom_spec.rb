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

require "rails_helper"

RSpec.describe Chatroom, type: :model do
  describe "#new" do
    it "does not pass without a name" do
      expect(FactoryBot.build(:chatroom, name: nil)).not_to be_valid
    end

    it "does not pass without language" do
      expect(FactoryBot.build(:chatroom, language: nil)).not_to be_valid
    end

    it { is_expected.to validate_uniqueness_of(:name).with_message("Already Exists") }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:language) }
    it { is_expected.to have_many(:messages) }
  end
end
