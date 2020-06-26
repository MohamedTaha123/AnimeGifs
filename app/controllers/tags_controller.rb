# frozen_string_literal: true

class TagsController < ApplicationController
  include TagsHelper

  def index
    @most_used = tag_names
  rescue StandardError => e
    puts e.to_s
  end

  def related_gifs
    @gif = Gif.new
    @most_used = tag_names
    @related_tag = params[:tag] 
    if @related_tag.present?
      @related_gifs = Gif.tagged_with(
        @related_tag
      )
    end
  rescue StandardError => e
    puts e.to_s
  end
end
