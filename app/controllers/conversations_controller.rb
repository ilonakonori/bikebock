class ConversationsController < ApplicationController
  def index # wip
    conv_rec = policy_scope(Conversation).where(recipient_id: current_user)
    conv_started = policy_scope(Conversation).where(sender_id: current_user)
    @conversations = conv_started + conv_rec
  end

  def show
    @conversation = Conversation.find(params[:id])
    authorize @conversation
  end

  def create
    @request = Request.find(params[:request_id])
    @conversation = Conversation.new(conversation_params)
    @request.update(accepted: true)
    authorize @conversation
    if @conversation.save
      redirect_to conversation_path(@conversation), notice: "Request accepted, start conversation :)"
    else
      render 'requests/show'
    end
  end

  private

  def conversation_params
    params.require(:conversation).permit(:request_id, :sender_id, :recipient_id)
  end
end
