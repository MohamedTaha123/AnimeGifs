# frozen_string_literal: true

class GifConvertorJob < ApplicationJob
  queue_as :default
  require 'rmagick'

  def perform(nwi, current_user)
    # Do something later
    anim = Magick::ImageList.new(
      *browse_images(nwi.images_hash)
    )

    anim.delay = 200
    anim.iterations = 2
    puts anim
    new_gif = anim.write('test_gif.gif')
    Gif.create!(id: nwi.gif_id, image: new_gif, user_id: current_user.id,
                tags_list: %w[1 2 3],
                description: nwi.description, label: nwi.label)
  end

  def browse_images(images)
    data = images.map do |img|
      File.basename(img.url)
    end
    data
  rescue StandardError => e
    puts e.to_s
  end
end
