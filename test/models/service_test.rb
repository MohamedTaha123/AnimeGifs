# == Schema Information
#
# Table name: services
#
#  id                  :integer          not null, primary key
#  user_id             :integer          not null
#  provider            :string
#  uid                 :string
#  access_token        :string
#  access_token_secret :string
#  refresh_token       :string
#  expires_at          :datetime
#  auth                :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'test_helper'

class ServiceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
