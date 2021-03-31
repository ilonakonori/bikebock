class ReviewsController < ApplicationController
  before_action :set_booking, only: :create

  def create
    @review = Review.new(review_params)
    @review.booking = @booking
    authorize @review
    if @review.save
      redirect_to request_path(@booking.action_id), notice: 'Thank you for your review!'
    else
      redirect_to request_path(@booking.action_id)
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
