class MessagesController < ApplicationController
  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = Message.create(message_params)
    @message.conversation = @conversation
    @message.recipient_id = @conversation.opposed_user(current_user).id
    @message.sender_id = current_user.id
    authorize @message
    if @message.save

      # wip: create notification if recipient not present /conversations/#{@conversation.id}
      m = Message.find(@message.id)
      sender_name = User.find(m.sender_id).name
      recipient = User.find(m.recipient_id)

      Notification.create!(
        user: recipient,
        sender_name: sender_name,
        action: 'Message',
        action_id: m.id,
        action_time: Time.now,
        read: false,
        content: "#{sender_name} sent you message",
        link: "/conversations/#{@conversation.id}#message-#{m.id}"
      )

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
