# frozen_string_literal: true

class GifConvertorJob < ApplicationJob
  queue_as :default
  require 'rmagick'

  def perform(new_image)
    # Do something later
    anim = Magick::ImageList.new(new_image.images_hash)
    anim.delay = 200
    anim.iterations = 2
    anim.write('test_gif.gif')
    Gif.create(image: 'test_gif.gif', description: new_image.description , label: new_image.label)
    exit
  end
end
