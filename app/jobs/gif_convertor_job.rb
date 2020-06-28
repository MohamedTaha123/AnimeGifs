# frozen_string_literal: true

class GifConvertorJob < ApplicationJob
  queue_as :default
  require 'mini_magick'
  require 'skeptick'
  include Skeptick
  def perform(nwi, current_user)
    # Skeptick & MiniMagick  Api
    new_gif = Rails.public_path.join('uploads','gif', "new_gif_#{nwi.id}.gif")
    command = convert(browse_images(nwi.images_hash)) do
      set :delay, '400'
      set :loop, '0'
      write new_gif
    end
    command.run
    Gif.new(id: nwi.gif_id, image: parse(new_gif.to_path), user_id: current_user.id,
                tag_list: %w[1 2 3],
                description: nwi.description, label: nwi.label).save
  rescue StandardError => e 
    puts e.to_s
  end

  def browse_images(images)
    data = images.map do |img|
      MiniMagick::Image.open("public/#{img.url}").path
    end
    data
  rescue StandardError => e
    puts e.to_s
  end
  def seed_image(file_path)
    File.open(
      File.join(file_path)
    )
  end
  def parse(filename )
    URI.parse(filename)
  end
end
