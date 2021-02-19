class RequestsController < ApplicationController
  def new
    @request = Request.new
    authorize @request
  end

  def create
    @request = Request.new(request_params)
    authorize @request
    if @request.save
      redirect_to user_path(@request.recipient_id)
    else
      render :new
    end
  end

  private

  def request_params
    params.require(:request).permit(:first_message, :recipient_id, :sender_id)
  end
end
