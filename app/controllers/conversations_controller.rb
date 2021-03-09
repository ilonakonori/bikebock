class ConversationsController < ApplicationController
  after_action :read_message_notifications, only: :show

  def index
    update_tracking
    @conversations = policy_scope(Conversation).where(recipient_id: current_user).order(created_at: :desc) + policy_scope(Conversation).where(sender_id: current_user).order(created_at: :desc)
  end

  def show
    @conversation = Conversation.find(params[:id])
    @message = Message.new
    @unread_msgs = Notification.where(read: false, action: 'Message', action_id: @conversation.id, user: current_user)
    update_tracking
    authorize @conversation
  end

  def create
    @request = Request.find(params[:id])
    @conversation = Conversation.new(
                      request_id: @request.id,
                      sender_id: @request.sender_id,
                      recipient_id: @request.recipient_id)
    authorize @conversation

    if @conversation.save

      @request.update(accepted: true, friend: true)
      c = Conversation.find(@conversation.id)
      sender_name = User.find(c.recipient_id).name
      recipient = User.find(c.sender_id)

      Notification.create!(
        user: recipient,
        sender_name: sender_name,
        action: 'Request',
        action_id: @request.id,
        action_time: Time.now,
        read: false,
        content: "#{sender_name} accepted your request :)",
        link: "/conversations/#{c.id}/"
      )

      #Message.create!(conversation_id: c.id, sender_id: c.sender_id, recipient_id: c.recipient_id, content: @request.first_message)

      #ConversationChannel.broadcast_to(@conversation, render_to_string(partial: "message", locals: { message: @message }))
      #redirect_to conversation_path(@conversation) #, anchor: "message-#{@message.id}")

      redirect_to conversation_path(@conversation), notice: "Request accepted, start conversation :)"
    else
      render 'requests/show'
    end
    update_tracking
  end

  def read_message_notifications
    if @unread_msgs.present?
      @unread_msgs.each do |n|
        n.update(read: true, read_at: Time.now)
      end
    end
  end

  def update_tracking
    tracking = Tracking.find_by(user: current_user.id)
    tracking.update!(location: request.url, location_time: Time.now)
  end

  private

  def conversation_params
    params.require(:conversation).permit(:request_id, :sender_id, :recipient_id)
  end
end
