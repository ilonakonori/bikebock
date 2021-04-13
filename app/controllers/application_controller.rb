class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :unread

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

  def unread
    if user_signed_in?
      unread_f = filter_blocked_u(current_user.notifications.where(read: false), 'sender_id')
      @unread = filter_blocked_u(unread_f, 'user_id').present?
      unread_requests_f = filter_blocked_u(current_user.notifications.where(read: false, action: 'Request'), 'sender_id')
      @unread_requests = filter_blocked_u(unread_requests_f, 'user_id').count
      unread_messages_f = filter_blocked_u(current_user.notifications.where(read: false, action: 'Message'), 'sender_id')
      @unread_messages = filter_blocked_u(unread_messages_f, 'user_id').count
      unread_notifications_f = filter_blocked_u(current_user.notifications.where(read: false), 'sender_id')
      @unread_notifications = filter_blocked_u(unread_notifications_f, 'user_id').count
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
