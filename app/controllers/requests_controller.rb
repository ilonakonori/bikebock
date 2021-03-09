class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :destroy]
  after_action :read_request_notification, only: :index

  def index
    @requests_sent = policy_scope(Request).where(accepted: false, sender_id: current_user.id)
    @requests_received = current_user.notifications.where(read: false, action: 'Request').order(action_time: :desc)
    @requests_read = current_user.notifications.where(read: true, action: 'Request').order(action_time: :desc).first(10)
    update_tracking
  end

 # def new
 #   @request = Request.new
 #   update_tracking
 #   authorize @request
 # end

  def show
    update_tracking
    @conversation = Conversation.new
  end

  def create
    ride = Ride.find(params[:ride_id])

    @request = Request.new(
                recipient_id: ride.user_id,
                sender_id: current_user.id,
                accepted: false,
                friend: false
                )

    #@request.recipient_id = ride.user_id
    #@request.sender_id = current_user.id
    #@request.accepted = false
    #@request.friend = false
    authorize @request

    if @request.save!

      r = Request.find(@request.id)
      sender_name = User.find(r.sender_id).name
      recipient = User.find(r.recipient_id)

      Notification.create!(
        user: recipient,
        sender_name: sender_name,
        action: 'Request',
        action_id: r.id,
        action_time: Time.now,
        read: false,
        link: "requests/#{r.id}",
        content: "#{sender_name} sent you request"
      )

      flash[:notice] = 'Request successfully sent'
      redirect_to ride_path(ride)
    end
    update_tracking
  end

  def destroy
    @request.destroy

    sender_name = User.find(@request.recipient_id).name
    recipient = User.find(@request.sender_id)

    Notification.create!(
        user: recipient,
        sender_name: sender_name,
        action: 'Request',
        action_id: @request.id,
        action_time: Time.now,
        read: false,
        content: "#{sender_name} declined your request :("
      )
    update_tracking
    redirect_to conversations_path(current_user), notice: 'You declined this request!'
  end

  def update_tracking
    tracking = Tracking.find_by(user: current_user.id)
    tracking.update!(location: request.url, location_time: Time.now)
  end

  private

  def read_request_notification
    if @requests_received.present?
      @requests_received.each do |n|
        n.update(read: true, read_at: Time.now)
      end
    end
  end

  def set_request
    @request = Request.find(params[:id])
    authorize @request
  end

 # def request_params
 #   params.require(:request).permit(:first_message, :recipient_id, :sender_id)
 # end
end
