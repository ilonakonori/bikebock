class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :unread

  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  private

  def unread
    if user_signed_in?
      @unread = current_user.notifications.where(read: false).present?
      @unread_requests = current_user.notifications.where(read: false, action: 'Request').count
      @unread_messages = current_user.notifications.where(read: false, action: 'Message').count
    end
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :about_me, :interests, :bike_photo, :last_seen, :profile_photo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :about_me, :interests, :bike_photo, :last_seen, :profile_photo])
  end
end
