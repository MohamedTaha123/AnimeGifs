# == Schema Information
#
# Table name: users
#
#  id                         :integer          not null, primary key
#  admin                      :boolean          default(FALSE)
#  announcements_last_read_at :datetime
#  email                      :string           default(""), not null
#  encrypted_password         :string           default(""), not null
#  first_name                 :string
#  last_name                  :string
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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
