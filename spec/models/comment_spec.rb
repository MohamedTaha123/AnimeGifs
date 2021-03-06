# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  body             :text
#  commentable_type :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :bigint           not null
#  user_id          :integer
#
# Indexes
#
#  index_comments_on_commentable_type_and_commentable_id  (commentable_type,commentable_id)
#

require "rails_helper"

RSpec.describe Comment, type: :model do
  describe "relationships" do
    it { is_expected.to belong_to(:commentable) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to belong_to(:user) }

    it do
      expect(subject).to validate_length_of(:body).
        is_at_most(100).
        on(:create)
    end

    it do
      expect(subject).to validate_length_of(:body).
        is_at_least(5).
        on(:create)
    end
  end
end
