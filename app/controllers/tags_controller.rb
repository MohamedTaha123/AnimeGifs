# frozen_string_literal: true

class TagsController < ApplicationController
  include TagsHelper

  def index
    @most_used = tag_names
  rescue StandardError => e
    puts e.to_s
  end
end
