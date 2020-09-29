# == Schema Information
#
# Table name: images
#
#  id          :bigint           not null, primary key
#  description :string
#  images_hash :json
#  label       :string
#  tag_list    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  gif_id      :string
#

require "rails_helper"

RSpec.describe Image, type: :model do
  describe "#new" do
    it { is_expected.to validate_presence_of(:images_hash) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:label) }

    it "does not accept a image without gif_id" do
      expect(:gif_id).not_to be_nil
    end
  end
end
