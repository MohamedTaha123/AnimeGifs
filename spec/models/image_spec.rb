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

require 'rails_helper'

RSpec.describe Image, type: :model do
  describe '#new' do
    it { should validate_presence_of(:images_hash) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:label) }
    it 'should not accept a image without gif_id' do
      
      expect(:gif_id).to_not be_nil 
    end
  end
end
