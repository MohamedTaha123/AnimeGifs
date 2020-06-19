# frozen_string_literal: true

class GifConvertorJob < ApplicationJob
  queue_as :default
  require 'rmagick'

  def perform(nwi)
    # Do something later
    anim = Magick::ImageList.new(
      *browse_images(nwi.images_hash) 
    ) 

    anim.delay = 200
    anim.iterations = 2
    anim.write('test_gif.gif')
    Gif.create(id: nwi.gif_id, image: "test_gif#{nwi.gif_id}.gif",
               description: new_image.description, label: new_image.label)
    exit
  end

  def browse_images(images)
    data = images.map(&:url)
    File.basename(data)
  rescue StandardError => e
    puts e.to_s
  end
end
