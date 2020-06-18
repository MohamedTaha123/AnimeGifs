# frozen_string_literal: true

class EditorController < ApplicationController
  before_action :authenticate_user!

  # GET editor/new
  def new
    @image = Image.new
  end

  def create
    @image = Image.create(images_params)
    GifConvertorJob.perform_now(@image.images_hash)
    respond_to do |format|
      if @image.save
        format.html { redirect_to new_path, notice: 'Image Saved' }

      else
        format.html { redirect_to new_path, alert: 'Can\'t Process' }
      end
    end
  end

  # POST editor/convert
  def convert
    @user = current_user
    @gif = @user.gifs.build
    @image = @gif.images.create(images_params)
    # GifConvertorJob.perform_now(@image, @user)
    if @image.save
      format.html { redirect_to root_path, notice: 'Converted Successfully' }

    else
      format.html { redirect_to new_path }

    end
  end

  private

  def images_params
    params.permit(:label, :description, images_hash: [])
  end
end
