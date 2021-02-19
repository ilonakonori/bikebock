class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :accept]

  def new
    @request = Request.new
    authorize @request
  end

  def show
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

  def accept
    @request.update!(accepted: true) #create chatroom on accept
    authorize @request
    flash[:notice] = 'Request was succesfully accepted'
    redirect_back(fallback_location: 'rides#index')
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
