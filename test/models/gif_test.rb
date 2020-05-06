# == Schema Information
#
# Table name: gifs
#
#  id                :integer          not null, primary key
#  description       :string
#  image             :string
#  impressions_count :integer
#  label             :string
#  slug              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer
#
# Indexes
#
#  index_gifs_on_slug  (slug) UNIQUE
#

require 'test_helper'

class GifTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
