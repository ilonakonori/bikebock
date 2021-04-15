class ReviewsController < ApplicationController
  before_action :set_booking, only: :create

  def create
    @review = Review.new(review_params)
    @review.booking = @booking
    @review.author_id = @booking.participant
    @review.author = User.find(@booking.participant).name

    authorize @review
    if @review.save

      r = Review.find(@review.id)
      sender_name = r.author
      recipient = User.find(r.booking.user_id)

      Notification.create!(
        user: recipient,
        sender_name: sender_name,
        sender_id: r.booking.participant,
        action: 'Review',
        action_id: r.id,
        action_time: Time.now,
        read: false,
        link: "/rides/#{r.booking.ride.id}",
        content: "Wrote a review: #{r.booking.ride.title}, #{r.booking.ride_date.strftime('%e %B %Y')}"
      )

      redirect_to request_path(@booking.action_id), notice: 'Thank you for your review!'
    else
      redirect_to request_path(@booking.action_id), notice: 'Something went wrong, please try again.'
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
