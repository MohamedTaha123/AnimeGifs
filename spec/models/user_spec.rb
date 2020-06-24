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
#  last_name                  :string
#  last_seen_at               :datetime
#  little_description         :string
#  remember_created_at        :datetime
#  reset_password_sent_at     :datetime
#  reset_password_token       :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

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

  describe '#havemany' do
    it { should have_many(:gifs) }
    it { should have_many(:services) }
    it { should have_many(:notifications) }
  end
end
