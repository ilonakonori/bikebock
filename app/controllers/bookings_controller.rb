class BookingsController < ApplicationController
  def create
    @request = Request.find(params[:request_id])
    @booking = Booking.new(
                 user_id: @request.recipient_id,
                 ride_id: @request.ride_id,
                 participant: @request.user_id,
                 action_id: @request.id,
                 ride_date: @request.ride_date.to_date)

    if @booking.save

      @request.update(updated_at: Time.now)

      notification = Notification.find_by(user: @request.user_id, action_id: @request.id, action: 'Request')

      notification.update!(
        action_time: Time.now,
        read: false,
        content: "Booked your request: #{@request.ride_date}, #{@request.ride.title}",
      )

      redirect_to request_path(@request), notice: "Request booked!"
    else
      render 'request#show'
    end
    authorize @booking
    update_tracking
  end

  def update_tracking
    tracking = Tracking.find_by(user: current_user.id)
    tracking.update!(location: request.url, location_time: Time.now)
  end
end
