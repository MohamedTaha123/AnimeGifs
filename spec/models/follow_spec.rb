# == Schema Information
#
# Table name: follows
#
#  id              :bigint           not null, primary key
#  blocked         :boolean          default(FALSE), not null
#  followable_type :string           not null
#  follower_type   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  followable_id   :bigint           not null
#  follower_id     :bigint           not null
#
# Indexes
#
#  fk_followables                                      (followable_id,followable_type)
#  fk_follows                                          (follower_id,follower_type)
#  index_follows_on_followable_type_and_followable_id  (followable_type,followable_id)
#  index_follows_on_follower_type_and_follower_id      (follower_type,follower_id)
#

require 'rails_helper'

RSpec.describe Follow, type: :model do
  describe '#new' do
    it 'should not pass without follower' do
      expect(FactoryBot.build(:follow, follower_id: nil)).to_not be_valid
    end
    it 'should not pass without followable' do
      expect(FactoryBot.build(:follow, followable_id: nil)).to_not be_valid
    end
  end
end
