class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :media]
  after_action :read_message_notifications, only: :show  # check read part!!

  def index
    conversations = policy_scope(Conversation).where(recipient_id: current_user).includes([:messages]) + policy_scope(Conversation).where(sender_id: current_user).includes([:messages])

    no_msgs = conversations.reject { |c| c.messages.present? }.sort_by.with_index { |c,i| [c["created_at"], i] }.reverse!
    c1 = filter_blocked(no_msgs, 'recipient_id')
    no_msgs_filtered = filter_blocked(c1, 'sender_id')

    # sort by last msg, w/o msgs at the bottom
    msgs_present = conversations.select { |c| c.messages.present? }.sort_by.with_index { |c,i| [c.messages.last["created_at"], i] }.reverse!
    c2 = filter_blocked(msgs_present, 'recipient_id')
    msgs_present_filtered = filter_blocked(c2, 'sender_id')

    @conversations = msgs_present_filtered + no_msgs_filtered

    update_tracking
  end

  def search
    cr = filter_blocked(Conversation.where(recipient_id: current_user).order(created_at: :desc).includes([:messages]), 'recipient_id')
    cr1 = filter_vanished(cr)
    cr2 = filter_blocked(cr1, 'sender_id')
    c1 = cr2.map { |c| [c.id, c.sender_id] }

    cs = filter_blocked(Conversation.where(sender_id: current_user).order(created_at: :desc).includes([:messages]), 'recipient_id')
    cs2 = filter_blocked(cs, 'sender_id')
    c2 = cs2.map { |c| [c.id, c.recipient_id] }

    c3 = (c1 + c2).map { |c| [User.find(c[1]).name.downcase, c[0]] }.sort!
    @autocomplete = c3.map { |c| c[0] }.to_json

    conversations = policy_scope(Conversation).where(recipient_id: current_user).includes([:messages]) + policy_scope(Conversation).where(sender_id: current_user).includes([:messages])

    no_msgs = conversations.reject { |c| c.messages.present? }.sort_by.with_index { |c,i| [c["created_at"], i] }.reverse!
    c1 = filter_blocked(no_msgs, 'recipient_id')
    no_msgs_filtered = filter_blocked(c1, 'sender_id')

    # sort by last msg, w/o msgs at the bottom
    msgs_present = conversations.select { |c| c.messages.present? }.sort_by.with_index { |c,i| [c.messages.last["created_at"], i] }.reverse!
    c2 = filter_blocked(msgs_present, 'recipient_id')
    msgs_present_filtered = filter_blocked(c2, 'sender_id')

    if params[:query].present?
      @query = params[:query]
      ids = c3.select { |c| c[0].match?(@query.downcase) }
      @conversations = ids.present? ? ids.map { |i| policy_scope(Conversation).find(i[1]) } : []
    else
      @conversations = msgs_present_filtered + no_msgs_filtered
    end
    update_tracking
  end

  def show
    @blocked = Blocking.find_by(blocked_user: @conversation.sender_id, user_id: @conversation.recipient_id) || Blocking.find_by(blocked_user: @conversation.recipient_id, user_id: @conversation.sender_id)
    @message = Message.new
    update_tracking
  end

  def search_messages
    @conversation = Conversation.find(params[:id])
    if params[:query].present?
      @query = params[:query]
      @messages = @conversation.messages.select { |m| m.content =~ /#{@query}/i }
    else
      @messages = @conversation.messages
    end
    @autocomplete = @conversation.messages.map { |m| m.content }.reject { |c| c == '' }.uniq.to_json
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
      sender_id: @request.recipient_id,
      action: 'Request',
      action_id: @request.id,
      action_time: Time.now,
      read: false,
      content: "Accepted your request: #{@request.ride_date}, #{@request.ride.title}",
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

  def filter_vanished(this_users)
    this_users.select do |c|
      User.where(id: c.sender_id).present?
    end
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
