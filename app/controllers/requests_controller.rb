class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :destroy]

  def new
    @request = Request.new
    authorize @request
  end

  def show
    @conversation = Conversation.new
  end

  def create
    @request = Request.new(request_params)
    authorize @request
    if @request.save

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
        content: "#{sender_name} sent you message request"
      )

      redirect_to user_path(@request.recipient_id), notice: 'Request was succesfully sent'
    else
      render :new
    end
  end

  def destroy
    @request.destroy

    sender_name = User.find(@request.recipient_id).name
    recipient = User.find(@request.sender_id)

    Notification.create!(
        user: recipient,
        sender_name: sender_name,
        action: 'Request declined',
        action_id: @request.id,
        action_time: Time.now,
        read: false,
        content: "#{sender_name} declined your message request :("
      )

    redirect_to conversations_path(current_user), notice: 'You declined this message request!'
  end

  private

  def set_request
    @request = Request.find(params[:id])
    authorize @request
  end

  def request_params
    params.require(:request).permit(:first_message, :recipient_id, :sender_id)
  end
end
