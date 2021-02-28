class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :destroy]

  def new
    @request = Request.new
    authorize @request
  end

  def show
    @conversation = Conversation.new
  end

  def create
    @request = Request.new(request_params)
    authorize @request
    if @request.save
      redirect_to user_path(@request.recipient_id), notice: 'Request was succesfully sent'
    else
      render :new
    end
  end

  def destroy
    @request.destroy
    redirect_to conversations_path(current_user), notice: 'You declined this message request!'
  end

  private

  def set_request
    @request = Request.find(params[:id])
    authorize @request
  end

  def request_params
    params.require(:request).permit(:first_message, :recipient_id, :sender_id)
  end
end
