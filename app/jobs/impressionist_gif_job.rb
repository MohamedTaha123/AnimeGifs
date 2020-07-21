class ImpressionistGifJob < ApplicationJob
  queue_as :default

  def perform(gif)
    impressionist(gif, message: "#{gif.label} get logged by impressionist")
  rescue => exception
    Rails.logger(exception) 
  end
end
