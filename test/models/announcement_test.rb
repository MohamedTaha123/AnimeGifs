# == Schema Information
#
# Table name: announcements
#
#  id                :integer          not null, primary key
#  published_at      :datetime
#  announcement_type :string
#  name              :string
#  description       :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class AnnouncementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
