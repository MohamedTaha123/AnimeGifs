# == Schema Information
#
# Table name: gifs
#
#  id                :integer          not null, primary key
#  image             :string
#  description       :string
#  label             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer
#  slug              :string
#  impressions_count :integer
#

require 'test_helper'

class GifTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
