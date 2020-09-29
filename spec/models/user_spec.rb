# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                         :bigint           not null, primary key
#  admin                      :boolean          default(FALSE)
#  announcements_last_read_at :datetime
#  avatar                     :string
#  deleted_at                 :datetime
#  email                      :string           default(""), not null
#  encrypted_password         :string           default(""), not null
#  facebook_url               :string
#  first_name                 :string
#  github_url                 :string
#  invitation_accepted_at     :datetime
#  invitation_created_at      :datetime
#  invitation_limit           :integer
#  invitation_sent_at         :datetime
#  invitation_token           :string
#  invitations_count          :integer          default(0)
#  invited_by_type            :string
#  last_name                  :string
#  last_seen_at               :datetime
#  little_description         :string
#  remember_created_at        :datetime
#  repos_hash                 :text
#  reset_password_sent_at     :datetime
#  reset_password_token       :string
#  session_token              :string
#  username                   :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  invited_by_id              :bigint
#
# Indexes
#
#  index_users_on_email                              (email) UNIQUE
#  index_users_on_invitation_token                   (invitation_token) UNIQUE
#  index_users_on_invitations_count                  (invitations_count)
#  index_users_on_invited_by_id                      (invited_by_id)
#  index_users_on_invited_by_type_and_invited_by_id  (invited_by_type,invited_by_id)
#  index_users_on_reset_password_token               (reset_password_token) UNIQUE
#

require "rails_helper"

RSpec.describe User, type: :model do
  describe "#new" do
    it "returns a new instance of user" do
      expect(FactoryBot.create(:user)).to be_valid
    end

    it "is invalid without a name" do
      expect(FactoryBot.build(:user, name: nil)).not_to be_valid
    end

    it "is invalid without an email" do
      expect(FactoryBot.build(:user, email: nil)).not_to be_valid
    end

    it "is invalid without a password" do
      expect(FactoryBot.build(:user, password: nil)).not_to be_valid
    end

    it "is invalid if email format is wrong" do
      expect(FactoryBot.build(:user, email: "testemail")).not_to be_valid
    end

    it { is_expected.to allow_value("https://github.com/test").for(:github_url) }
    it { is_expected.to allow_value("https://facobook.com/test").for(:facebook_url) }
  end

  describe "#uniqueness" do
    it { is_expected.to validate_uniqueness_of(:facebook_url).scoped_to(:id) }
    it { is_expected.to validate_uniqueness_of(:github_url).scoped_to(:id) }
  end

  describe "#havemany" do
    it { is_expected.to have_many(:gifs) }
    it { is_expected.to have_many(:services) }
    it { is_expected.to have_many(:notifications) }
  end
end
