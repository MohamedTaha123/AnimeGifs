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

require "rails_helper"

RSpec.describe Message, type: :model do
  describe "#new" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:chatroom) }
    it { is_expected.to validate_presence_of(:content).on(:create) }
    it { is_expected.to validate_length_of(:content).is_at_most(500) }
    it { is_expected.to validate_length_of(:content).is_at_least(10) }
  end

  describe "#conditionals" do
    context "attachement present" do
      before { subject.attachement.present? }

      it { is_expected.to validate_presence_of(:content) }
    end

    context "attachement not present" do
      before do
        subject.attachement.blank?
      end

      it { is_expected.to validate_presence_of(:content).on(:create) }
    end
  end

  context "accept a nested resources" do
    expect(subject).to accept_nested_attributes_for(:user)
  end
end
