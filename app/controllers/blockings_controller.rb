class BlockingsController < ApplicationController
  def index
    #@blocked_users = policy_scope(Blocking)
  end

  def create
    @blocking = current_user.blockings.create(blocked_user: params[:user_id])
    authorize @blocking
    redirect_to user_path(@blocking.blocked_user), notice: 'User successfully blocked!'
    update_tracking
  end

  def destroy
    @blocking = Blocking.find(params[:id])
    user = @blocking.blocked_user
    @blocking.destroy
    authorize @blocking
    redirect_to user_path(user), notice: 'User succesfully unblocked!'
    update_tracking
  end

  def update_tracking
    tracking = Tracking.find_by(user: current_user.id)
    tracking.update!(location: request.url, location_time: Time.now)
  end
end
