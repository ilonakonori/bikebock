class MessagesController < ApplicationController
  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = Message.create(message_params)
    @message.conversation = @conversation
    @message.recipient_id = @conversation.opposed_user(current_user).id
    @message.sender_id = current_user.id
    authorize @message
    if @message.save
      ConversationChannel.broadcast_to(@conversation, render_to_string(partial: "message", locals: { message: @message }))
      redirect_to conversation_path(@conversation, anchor: "message-#{@message.id}")
    else
      render "conversations/show"
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
