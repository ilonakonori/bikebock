class BlockingsController < ApplicationController
  respond_to :html, :js

  def create
    @blocking = current_user.blockings.create(blocked_user: params[:user_id])
    authorize @blocking
    redirect_to rides_path, notice: 'User successfully blocked!'
    update_tracking
  end

  def destroy
    @blocking = Blocking.find(params[:id])
    @blocking.destroy
    authorize @blocking
    update_tracking
  end

  def update_tracking
    tracking = Tracking.find_by(user: current_user.id)
    tracking.update!(location: request.url, location_time: Time.now)
  end
end
