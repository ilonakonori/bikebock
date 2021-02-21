class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :accept]

  def index
    @requests_received = policy_scope(Request).where(accepted: false, recipient_id: current_user.id)
    @requests_sent = policy_scope(Request).where(accepted: false, sender_id: current_user.id)
  end

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

  private

  def set_request
    @request = Request.find(params[:id])
    authorize @request
  end

  def request_params
    params.require(:request).permit(:first_message, :recipient_id, :sender_id)
  end
end
