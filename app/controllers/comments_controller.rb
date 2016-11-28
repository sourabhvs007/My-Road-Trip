# Comments controller
class CommentsController < ApplicationController
  before_filter :require_login, only: [:new, :create]
  def new
    @comment = Comment.new
    respond_to do |format|
      format.html {}
    end
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @trip = Trip.find_by_id(@comment.trip_id)
    if @comment.valid? && @comment.errors.blank?
      @comment.save
      redirect_to trip_path(@trip), notice: 'Comment Added!'
    else
      redirect_to trip_path(@comment.trip_id), notice: 'Comment cannot be added!'

    end
  end

  def comment_params
    params.require(:comment).permit(:message, :trip_id)
  end
end
