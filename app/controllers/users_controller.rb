class UsersController < ApplicationController
  before_action :set_user, only: [:show, :presence]
  after_action :read_notification, only: :notifications

  def show
    @requests_received = Request.where(accepted: false, recipient_id: @user.id)
    @requests_sent = Request.where(accepted: false, sender_id: @user.id)
  end

  def presence
    if @user.id == current_user.id
      @user.update(last_seen: DateTime.now)
    end
  end

  def bookmarks
    @user = current_user
    @bookmarks = @user.favorites.order('created_at desc')
    authorize @user
  end

  def notifications # works good
    @user = current_user
    msgs = @user.notifications.where(read: false, action: 'Message').select(:sender_name).group(:sender_name).having("count(*) > 1").select(:sender_name).size

    msgs.each do |m|
      @user.notifications.create!(
        user: @user,
        sender_name: m[0],
        action: 'Messages',
        action_time: @user.notifications.where(sender_name: m[0], action: 'Message').last.action_time,
        read: false,
        content: "#{m[0]} sent you #{m[1]} messages",
        link: @user.notifications.where(read: false, action: 'Message', sender_name: m[0]).first.link
      )
      @user.notifications.where(read: false, action: 'Message', sender_name: m[0]).destroy_all
    end
    @notifications = @user.notifications.where(read: false).order(action_time: :desc)
    @notifications_read = @user.notifications.where(read: true).order(created_at: :desc).first(10)
    authorize @user
  end

  private

  def read_notification
    if @notifications.present?
      @notifications.each do |n|
        n.update(read: true)
      end
    end
  end

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end
end
