class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :unread
  before_action :set_notifications_u, only: :unread
  before_action :set_theme

  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: [:index, :search, :received, :sent], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: [:index, :search, :received, :sent], unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  private

  def set_theme
    if user_signed_in?
      cookies[:theme] = current_user.account.theme
    end
  end

  def unread
    if user_signed_in?
      unread_f = filter_blocked_u(current_user.notifications.where(read: false), 'sender_id')
      @unread = filter_blocked_u(unread_f, 'user_id').present?
      unread_requests_f = filter_blocked_u(current_user.notifications.where(read: false, action: 'Request'), 'sender_id')
      @unread_requests = filter_blocked_u(unread_requests_f, 'user_id').count

      unread_msgs = filter_blocked_u(current_user.notifications.where(read: false, action: 'Messages'), 'sender_id')
      unread_msgs_u = filter_blocked_u(unread_msgs, 'user_id')
      unread_msgs_c = unread_msgs.map { |n| n.content.match(/\d+/)[0].to_i }.sum

      unread_messages_f = filter_blocked_u(current_user.notifications.where(read: false, action: 'Message'), 'sender_id')
      @unread_messages = filter_blocked_u(unread_messages_f, 'user_id').count + unread_msgs_c
      unread_notifications_f = filter_blocked_u(current_user.notifications.where(read: false), 'sender_id')
      @unread_notifications = filter_blocked_u(unread_notifications_f, 'user_id').count
    end
  end

  def set_notifications_u
    msgs = current_user.notifications.where(read: false, action: 'Message').select(:sender_id).group(:sender_id).having("count(*) > 1").select(:sender_id).size
    msgs.each do |m|
      sender_name = User.find(m[0]).name
      current_user.notifications.create!(
        user: current_user,
        sender_name: sender_name,
        sender_id: m[0],
        action: 'Messages',
        action_id: current_user.notifications.where(read: false, action: 'Message', sender_id: m[0]).first.action_id,
        action_time: current_user.notifications.where(sender_id: m[0], action: 'Message').last.action_time,
        read: false,
        content: "Sent you #{m[1]} messages",
        link: current_user.notifications.where(read: false, action: 'Message', sender_name: sender_name).first.link
      )
      current_user.notifications.where(read: false, action: 'Message', sender_id: m[0]).destroy_all
    end
  end

  def filter_blocked_u(this_users, this_id)
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

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :about_me, :interests, :bike_photo, :last_seen, :profile_photo, :email_ciphertext, :email_bidx])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :about_me, :interests, :bike_photo, :last_seen, :profile_photo, :email_ciphertext, :email_bidx])
  end
end
