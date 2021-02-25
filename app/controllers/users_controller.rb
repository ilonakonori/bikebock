class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @requests_received = Request.where(accepted: false, recipient_id: @user.id)
    @requests_sent = Request.where(accepted: false, sender_id: @user.id)
    authorize @user
  end

  def presence
    @user = User.find(params[:id])
    if @user.id == current_user.id
      @user.update(last_seen: DateTime.now)
    end
    authorize @user
  end
end
