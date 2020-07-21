class ImpressionistGifJob < ApplicationJob
  queue_as :default
  include Impressionist
  def perform(gif, impression_params = {})
    gif.impressions.create(impression_params)
  end
end
