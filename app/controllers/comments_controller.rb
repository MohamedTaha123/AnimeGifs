# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable, only: :create

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_back fallback_location: @comment, notice: "Your comment was successfully posted!"
    else
      redirect_back fallback_location: @comment, alert: "Your comment wasn't posted!"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_commentable
    if params[:comment_id]
      @commentable = Comment.find_by(id: params[:comment_id])
    end
    @commentable = Gif.friendly.find(params[:gif_id]) if params[:gif_id]
  end
end
