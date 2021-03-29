class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :update]
  after_action :read_notifications, only: :index

  def index # imp this!
    @requests_sent = policy_scope(Request).where(user_id: current_user.id).order(:accepted).order(updated_at: :desc)
    @requests_received = policy_scope(Request).where(recipient_id: current_user.id).order(updated_at: :desc)
    #@requests_received_old = policy_scope(Request).where(accepted: true, recipient_id: current_user.id)
    #@requests_read = current_user.notifications.where(read: true, action: 'Request').order(action_time: :desc).first(10)
    notifications = Notification.where(read: false, user: current_user.id, action: 'Request').order(created_at: :desc)
    @r_num = notifications.select { |n| n[:content].match?(/sent/) }.size
    @s_num = notifications.reject { |n| n[:content].match?(/sent/) }.size
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
        action: 'Request',
        action_id: r.id,
        action_time: Time.now,
        read: false,
        link: "/requests/#{r.id}",
        content: "#{sender_name} sent you request: #{r.ride_date}, #{r.ride.title}"
      )

      flash[:notice] = 'Request successfully sent'
      redirect_to ride_path(@request.ride_id, anchor: "request")
    end
    update_tracking
  end

  def update
    sender_name = User.find(@request.recipient_id).name
    recipient = User.find(@request.user_id)

    Notification.create!(
        user: recipient,
        sender_name: sender_name,
        action: 'Request',
        action_id: @request.id,
        action_time: Time.now,
        read: false,
        link: "/requests/#{@request.id}",
        content: "#{sender_name} declined your request: #{@request.ride_date}, #{@request.ride.title}"
      )

    @request.update(accepted: false)

    update_tracking
    redirect_to request_path(@request), notice: 'You declined this request!'
  end

  def update_tracking
    tracking = Tracking.find_by(user: current_user.id)
    tracking.update!(location: request.url, location_time: Time.now)
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
