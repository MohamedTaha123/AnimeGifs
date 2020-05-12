# frozen_string_literal: true

module EditorHelper
  require 'rmagick'
  def convert_to_gif(images, gif_name)
    if images.any?
        anim = Magick::ImageList.new(images)
        anim.iterations = 2
        anim.delay = 200
        anim.write(gif_name)
    else 
        puts 'cant process this action'
        
    end
  end
end
