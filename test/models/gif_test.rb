# == Schema Information
#
# Table name: gifs
#
#  id                :bigint           not null, primary key
#  description       :string
#  image             :string
#  impressions_count :integer
#  label             :string
#  language          :string
#  slug              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :bigint
#
# Indexes
#
#  index_gifs_on_slug     (slug) UNIQUE
#  index_gifs_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'test_helper'

class GifTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
