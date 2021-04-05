class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :media]
  after_action :read_message_notifications, only: :show  # check read part

  def index
    conversations = policy_scope(Conversation).where(recipient_id: current_user).includes([:messages]) + policy_scope(Conversation).where(sender_id: current_user).includes([:messages])
    c = conversations.reject { |c| c.messages.present? }.sort_by.with_index { |c,i| [c["created_at"], i] }.reverse!
    # sort by last msg, w/o msgs at the bottom
    @conversations = conversations.select { |c| c.messages.present? }.sort_by.with_index { |c,i| [c.messages.last["created_at"], i] }.reverse! + c
    update_tracking
  end

  def search
    c1 = Conversation.where(recipient_id: current_user).order(created_at: :desc).includes([:messages]).map { |c| [c.id, c.sender_id] }
    c2 = Conversation.where(sender_id: current_user).order(created_at: :desc).includes([:messages]).map { |c| [c.id, c.recipient_id] }
    c3 = (c1 + c2).map { |c| [User.find(c[1]).name.downcase, c[0]] }.sort!
    @autocomplete = c3.map { |c| c[0] }
    conversations = policy_scope(Conversation).where(recipient_id: current_user).includes([:messages]) + policy_scope(Conversation).where(sender_id: current_user).includes([:messages])
    c = conversations.reject { |c| c.messages.present? }.sort_by.with_index { |c,i| [c["created_at"], i] }.reverse!

    if params[:query].present?
      @query = params[:query]
      ids = c3.select { |c| c[0].match?(@query.downcase) }
      @conversations = ids.present? ? ids.map { |i| policy_scope(Conversation).find(i[1]) } : []
    else
      @conversations = conversations.select { |c| c.messages.present? }.sort_by.with_index { |c,i| [c.messages.last["created_at"], i] }.reverse! + c
    end
    update_tracking
  end

  def show
    @message = Message.new
    update_tracking
  end

  def search_messages
    @conversation = Conversation.find(params[:id])
    if params[:query].present?
      @query = params[:query]
      @messages = @conversation.messages.search_content(@query)
    else
      @messages = @conversation.messages
    end
    @autocomplete = @conversation.messages.map { |m| m.content }.reject { |c| c == '' }.uniq!
    authorize @conversation
    update_tracking
  end

  def media
    #@media_sent = @conversation.messages.where(sender_id: current_user.id).order(created_at: :desc).select { |m| m.attachment.attached? }
    #@media_received = @conversation.messages.where(recipient_id: current_user.id).order(created_at: :desc).select { |m| m.attachment.attached? }
    @media = @conversation.messages.order(created_at: :desc).select { |m| m.attachment.attached? }.group_by { |m| m.created_at.beginning_of_month }
    update_tracking
  end

  def create
    @request = Request.find(params[:request_id])

    if !conversated
      @conversation = Conversation.create(sender_id: @request.user_id, recipient_id: @request.recipient_id)
    end

    @request.update(accepted: true, friend: true)

    sender_name = User.find(@request.recipient_id).name
    recipient = User.find(@request.user_id)

    Notification.create!(
      user: recipient,
      sender_name: sender_name,
      action: 'Request',
      action_id: @request.id,
      action_time: Time.now,
      read: false,
      content: "#{sender_name} accepted your request: #{@request.ride_date}, #{@request.ride.title}",
      link: "/requests/#{@request.id}"
    )

    authorize @conversation
    redirect_to request_path(@request), notice: "Request accepted"
    update_tracking
  end

  def update_tracking
    tracking = Tracking.find_by(user: current_user.id)
    tracking.update!(location: request.url, location_time: Time.now)
  end

  private

  def read_message_notifications
    msgs = Notification.where(read: false, action: 'Message', action_id: @conversation.id, user: current_user) + Notification.where(user: current_user, action: 'Messages', action_id: @conversation.id, read: false)
    if msgs.present?
      msgs.each do |n|
        n.update(read: true, read_at: Time.now)
      end
    end
  end

  def conversated
    @request = Request.find(params[:request_id])
    @conversation = Conversation.find_by(sender_id: @request.user_id, recipient_id: @request.recipient_id) || Conversation.find_by(recipient_id: @request.user_id, sender_id: @request.recipient_id)
  end

  def set_conversation
    @conversation = Conversation.find(params[:id])
    authorize @conversation
  end
end
