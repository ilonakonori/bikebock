class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @requests_received = Request.where(accepted: false, recipient_id: @user.id)
    @requests_sent = Request.where(accepted: false, sender_id: @user.id)

    authorize @user
  end
end
