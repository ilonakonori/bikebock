class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :media]
  after_action :read_message_notifications, only: :show

  def index
    update_tracking
    @conversations = policy_scope(Conversation).where(recipient_id: current_user).order(created_at: :desc) + policy_scope(Conversation).where(sender_id: current_user).order(created_at: :desc)
  end

  def show
    @message = Message.new
    @unread_msgs = Notification.where(read: false, action: 'Message', action_id: @conversation.id, user: current_user)
    update_tracking
  end

  def media
    #@media_sent = @conversation.messages.where(sender_id: current_user.id).order(created_at: :desc).select { |m| m.attachment.attached? }
    #@media_received = @conversation.messages.where(recipient_id: current_user.id).order(created_at: :desc).select { |m| m.attachment.attached? }
    @media = @conversation.messages.order(created_at: :desc).select { |m| m.attachment.attached? }.group_by { |m| m.created_at.beginning_of_month }
  end

  def create
    if !conversated
      @request = Request.find(params[:id])
      @conversation = Conversation.create(
                        request_id: @request.id,
                        sender_id: @request.user_id,
                        recipient_id: @request.recipient_id)
    end

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

    authorize @conversation
    redirect_to conversation_path(@conversation), notice: "Request accepted, start conversation :)"
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

  def conversated
    @request = Request.find(params[:id])
    @conversation = Conversation.find_by(sender_id: @request.user_id, recipient_id: @request.recipient_id)
  end

  def set_conversation
    @conversation = Conversation.find(params[:id])
    authorize @conversation
  end
end
