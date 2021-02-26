class UsersController < ApplicationController
  before_action :set_user, only: [:show, :presence]

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

  def notifications
    @user = current_user
    @notifications = @user.notifications.where(read: false).order(created_at: :desc)
    authorize @user
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end
end
