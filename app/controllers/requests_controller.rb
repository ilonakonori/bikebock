class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :update]
  after_action :read_notifications, only: :index

  def received
    received = filter_blocked(policy_scope(Request).where(recipient_id: current_user.id).includes([:ride]), 'recipient_id')
    @requests_received = filter_blocked(received, 'user_id')

    @rr = @requests_received.map do |request|
      { request: request,
        notification: Notification.find_by(user: current_user.id, action_id: request.id, action: 'Request', read: false).present?,
        all_bookings: Booking.where(ride_id: request.ride_id, ride_date: request.ride_date.to_date).length < request.ride.number_of_people.to_i,
        check_book: Booking.find_by(participant: request.user_id, ride_id: request.ride_id, ride_date: request.ride_date.to_date)
      }
    end.sort_by { |r| r[:request].updated_at }.sort_by {|r| r[:notification].to_s }.reverse!

    update_tracking
  end

  def sent
    sent = filter_blocked(policy_scope(Request).where(user_id: current_user.id).includes([:ride]), 'recipient_id')
    @requests_sent = filter_blocked(sent, 'user_id')

    @rs = @requests_sent.map do |request|
      { request: request,
        notification: Notification.find_by(user: current_user.id, action_id: request.id, action: 'Request', read: false).present?,
        all_bookings: Booking.where(ride_id: request.ride_id, ride_date: request.ride_date.to_date).length < request.ride.number_of_people.to_i,
        check_book: Booking.find_by(participant: request.user_id, ride_id: request.ride_id, ride_date: request.ride_date.to_date)
      }
    end.sort_by { |r| r[:request].updated_at }.sort_by {|r| r[:notification].to_s }.reverse!
    update_tracking
  end

  def show
    unread = Notification.find_by(user: current_user.id, action_id: @request.id, read: false)
    unread.update(read: true) unless unread.nil?
    @chat = Conversation.find_by(sender_id: @request.user_id, recipient_id: @request.recipient_id) || Conversation.find_by(recipient_id: @request.user_id, sender_id: @request.recipient_id)
    @conversation = Conversation.new
    # find all bookings for given ride and given date
    @all_bookings = Booking.where(ride_id: @request.ride_id, ride_date: @request.ride_date.to_date).length < @request.ride.number_of_people.to_i
    @check_book = Booking.find_by(participant: @request.user_id, ride_id: @request.ride_id, ride_date: @request.ride_date.to_date)
    @booking = Booking.new
    @review = Review.new
    @participants = Booking.where(ride_id: @request.ride_id, ride_date: @request.ride_date.to_date).map { |b| User.find(b.participant) }
    update_tracking
  end

  def new
  end

  def create
    @request = current_user.requests.new(request_params)
    @request.user_id = current_user.id
    @request.accepted = nil;

    authorize @request

    if @request.save!

      r = Request.find(@request.id)
      sender_name = User.find(r.user_id).name
      recipient = User.find(r.recipient_id)

      Notification.create!(
        user: recipient,
        sender_name: sender_name,
        sender_id: r.user_id,
        action: 'Request',
        action_id: r.id,
        action_time: Time.now,
        read: false,
        link: "/requests/#{r.id}",
        content: "Sent you request: #{r.ride_date}, #{r.ride.title}"
      )

      flash[:notice] = 'Request successfully sent'
      redirect_to sent_requests_path # or show page? request_path(@request)
    end
    update_tracking
  end

  def update
    sender_name = User.find(@request.recipient_id).name
    recipient = User.find(@request.user_id)

    Notification.create!(
        user: recipient,
        sender_name: sender_name,
        sender_id: @request.recipient_id,
        action: 'Request',
        action_id: @request.id,
        action_time: Time.now,
        read: false,
        link: "/requests/#{@request.id}",
        content: "Declined your request: #{@request.ride_date}, #{@request.ride.title}"
      )

    @request.update(accepted: false)

    update_tracking
    redirect_to request_path(@request), notice: 'You declined this request!'
  end

  def update_tracking
    tracking = Tracking.find_by(user: current_user.id)
    tracking.update!(location: request.url, location_time: Time.now)
  end

  def filter_blocked(this_users, this_id)
    # don't display users that current_user blocked
    blocked_users = current_user.blockings.map { |b| b.blocked_user }
    # don't display users that blocked current_user
    user_blocked_by = Blocking.all.select do |b|
                        if b.blocked_user == current_user.id
                          b
                        end
                      end.map { |b| b.user_id }

    this_users.reject do |t|
      if blocked_users.include?(t[this_id]) || user_blocked_by.include?(t[this_id])
        t
      end
    end
  end

  private

  def read_notifications
    unread = Notification.where(user: current_user, read: false, link: nil)
    if unread.length.positive?
      unread.each { |n| n.update!(read: true, read_at: Time.now) }
    end
  end

  def set_request
    @request = Request.find(params[:id])
    authorize @request
  end

  def request_params
    params.require(:request).permit(:recipient_id, :user_id, :ride_date, :ride_id, :accepted, :friend)
  end
end
