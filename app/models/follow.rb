# == Schema Information
#
# Table name: follows
#
#  id              :integer          not null, primary key
#  followable_type :string           not null
#  followable_id   :integer          not null
#  follower_type   :string           not null
#  follower_id     :integer          not null
#  blocked         :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Follow < ActiveRecord::Base

  extend ActsAsFollower::FollowerLib
  extend ActsAsFollower::FollowScopes

  # NOTE: Follows belong to the "followable" and "follower" interface
  belongs_to :followable, polymorphic: true
  belongs_to :follower,   polymorphic: true

  def block!
    self.update_attribute(:blocked, true)
  end

end
