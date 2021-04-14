class UsersController < ApplicationController
  before_action :set_user, only: [:show, :presence, :unread]
  before_action :set_notifications, only: [:notifications, :unread]
  after_action :read_notifications, only: :notifications
  respond_to :html, :js

  def show
    @blocked = current_user.blockings.find_by(blocked_user: @user.id)
    @blocked_current = @user.blockings.find_by(blocked_user: current_user.id)
    update_tracking
  end

  def presence
    if @user.id == current_user.id
      @user.update(last_seen: DateTime.now)
    end
  end

  def bookmarks
    @user = current_user
    @bookmarks = filter_bookmarks(@user.favorites.order(created_at: :desc), 'user_id')
    update_tracking
    authorize @user
  end

  def notifications # works good
    @user = current_user
    notifications_f = filter_blocked(@user.notifications.order(action_time: :desc), 'sender_id')
    @notifications = filter_blocked(notifications_f, 'user_id')
    update_tracking
    authorize @user
  end

  def privacy
    @user = current_user
    @blocked = @user.blockings.order(created_at: :desc)
    update_tracking
    authorize @user
  end

  def unread
    @user = current_user
    unread_f = filter_blocked(@user.notifications.where(read: false), 'sender_id')
    @unread = filter_blocked(unread_f, 'user_id').present?
    unread_requests_f = filter_blocked(@user.notifications.where(read: false, action: 'Request'), 'sender_id')
    @unread_requests = filter_blocked(unread_requests_f, 'user_id').count

    unread_msgs = filter_blocked(@user.notifications.where(read: false, action: 'Messages'), 'sender_id')
    unread_msgs_u = filter_blocked(unread_msgs, 'user_id')
    unread_msgs_c = unread_msgs.map { |n| n.content.match(/\d+/)[0].to_i }.sum
    unread_messages_f = filter_blocked(@user.notifications.where(read: false, action: 'Message'), 'sender_id')
    @unread_messages = filter_blocked(unread_messages_f, 'user_id').count + unread_msgs_c

    unread_notifications_f = filter_blocked(@user.notifications.where(read: false), 'sender_id')
    @unread_notifications = filter_blocked(unread_notifications_f, 'user_id').count
    authorize @user
     respond_to do |format|
      format.html
      format.json { render json: { unread: @unread, requests: @unread_requests, messages: @unread_messages, notifications: @unread_notifictions } }
    end
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

  def filter_bookmarks(this_users, this_id)
    # don't display users that current_user blocked
    blocked_users = current_user.blockings.map { |b| b.blocked_user }
    # don't display users that blocked current_user
    user_blocked_by = Blocking.all.select do |b|
                        if b.blocked_user == current_user.id
                          b
                        end
                      end.map { |b| b.user_id }

    this_users.reject do |t|
      if blocked_users.include?(t.favoritable[this_id]) || user_blocked_by.include?(t.favoritable[this_id])
        t
      end
    end
  end

  def set_notifications
    @user = current_user
    msgs = @user.notifications.where(read: false, action: 'Message').select(:sender_id).group(:sender_id).having("count(*) > 1").select(:sender_id).size

    msgs.each do |m|
      sender_name = User.find(m[0]).name
      @user.notifications.create!(
        user: @user,
        sender_name: sender_name,
        sender_id: m[0],
        action: 'Messages',
        action_id: @user.notifications.where(read: false, action: 'Message', sender_id: m[0]).first.action_id,
        action_time: @user.notifications.where(sender_id: m[0], action: 'Message').last.action_time,
        read: false,
        content: "Sent you #{m[1]} messages",
        link: @user.notifications.where(read: false, action: 'Message', sender_name: sender_name).first.link
      )
      @user.notifications.where(read: false, action: 'Message', sender_id: m[0]).destroy_all
    end
    authorize @user
  end

  def read_notifications
    unread = Notification.where(user: current_user, action: 'Request', read: false, link: nil)
    if unread.length.positive?
      unread.each { |n| n.update!(read: true, read: Time.now) }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end
end
