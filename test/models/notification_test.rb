# == Schema Information
#
# Table name: notifications
#
#  id              :integer          not null, primary key
#  recipient_id    :bigint
#  actor_id        :bigint
#  read_at         :datetime
#  action          :string
#  notifiable_id   :bigint
#  notifiable_type :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
