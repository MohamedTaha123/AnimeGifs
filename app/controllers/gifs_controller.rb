# frozen_string_literal: true

class GifsController < ApplicationController
  before_action :set_gif, only: %i[show edit update destroy like unlike follow unfollow]
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_activities, only: %i[index show new edit]
  impressionist actions: [:show]

  # GET /gifs
  # GET /gifs.json
  def index
    @q = Gif.ransack(params[:q])
    @gifs = @q.result(distinct: true)
    @trending = Gif.last(5).reverse
  end

  # GET /gifs/1
  # GET /gifs/1.json
  def show
    @gif = Gif.friendly.find(params[:id])
    impressionist(@gif)
  rescue StandardError => e
    puts e.to_s
  end

  # GET /gifs/new
  def new
    @gif = Gif.new
  end

  # GET /gifs/1/edit
  def edit; end

  # POST /gifs
  # POST /gifs.json
  def create
    @user = current_user
    @gif = @user.gifs.build(gif_params)
    respond_to do |format|
      if @gif.save
        format.html { redirect_to @gif, notice: 'Gif was successfully created.' }
        format.json { render :show, status: :created, location: @gif }
      else
        format.html { render :new }
        format.json { render json: @gif.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gifs/1
  # PATCH/PUT /gifs/1.json
  def update
    respond_to do |format|
      if @gif.update(gif_params)
        format.html { redirect_to @gif, notice: 'Gif was successfully updated.' }
        format.json { render :show, status: :ok, location: @gif }
      else
        format.html { render :edit }
        format.json { render json: @gif.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gifs/1
  # DELETE /gifs/1.json
  def destroy
    @gif.destroy
    respond_to do |format|
      format.html { redirect_to gifs_url, notice: 'Gif was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # PUT /gifs/1/like
  def like
    @gif.liked_by current_user
    respond_to do |format|
      format.html { redirect_to request.referer, notice: 'Liked.' }
      format.json { head :no_content }
    end
  end

  # PUT /gifs/1/unlike
  def unlike
    @gif.unliked_by current_user
    respond_to do |format|
      format.html { redirect_to request.referer, alert: 'Unliked' }
      format.json { head :no_content }
    end
  end

  def follow
    @user = @gif.user
    current_user.follow(@user)
    Notification.create!(recipient: @gif.user, actor: current_user, action: 'follow', notifiable: @user)
    ActionCable.server.broadcast('welcome_channel', "You Start Following #{@user.name}.")
    # ActionCable.server.broadcast('welcome_channel', "#{current_user} Start Following You.")
    respond_to do |format|
      format.html { redirect_to request.referer, alert: 'Followed' }
      format.json { head :no_content }
    end
  end

  def unfollow
    @user = @gif.user
    current_user.stop_following(@user)
    Notification.create!(recipient: @gif.user, actor: current_user, action: 'unfollow', notifiable: @user)
    respond_to do |format|
      format.html { redirect_to request.referer, alert: 'Unfollowed' }
      format.json { head :no_content }
    end
  end

  private

  # Activity Load
  def load_activities
    @activities = PublicActivity::Activity.order('created_at DESC').limit(20)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_gif
    @gif = Gif.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def gif_params
    params.require(:gif).permit(:image, :description, :label, :image_cache)
  end
end
