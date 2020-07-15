# frozen_string_literal: true

class EditorController < ApplicationController
  before_action :authenticate_user!

  # GET /new
  def new
    @image = Image.new
  end

  def create
    @image = Image.create(images_params)
    GifConvertorJob.perform_now(@image, current_user)
    respond_to do |format|
      if @image.save
        format.html { redirect_to new_path }

      else
        format.html { redirect_to new_path, alert: 'Can\'t Process' }
      end
    end
  end

  # POST /convert
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
    params.require(:image).permit(:label, :description, :tag_list,images_hash: [])
  end
end
