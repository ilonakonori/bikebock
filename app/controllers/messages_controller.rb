class MessagesController < ApplicationController
  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = Message.create(message_params)
    @message.conversation = @conversation
    @message.recipient_id = @conversation.opposed_user(current_user).id
    @message.sender_id = current_user.id
    authorize @message
    if @message.save

      m = Message.find(@message.id)
      sender_name = User.find(m.sender_id).name
      recipient = User.find(m.recipient_id)

      if !recipient.online? || recipient.online? && recipient.tracking.location != "http://localhost:3000/conversations/#{@conversation.id}"
        Notification.create!(
          user: recipient,
          sender_name: sender_name,
          action: 'Message',
          action_id: @conversation.id,
          action_time: Time.now,
          read: false,
          content: "#{sender_name} sent you message",
          link: "/conversations/#{@conversation.id}#message-#{m.id}"
        )
      end

      sender = render_to_string(partial: "messages/sent", locals: { message: @message })
      receiver = render_to_string(partial: "messages/received", locals: { message: @message })

      ConversationChannel.broadcast_to(
        @conversation,
        sender: sender, receiver: receiver, message: @message
      )
      redirect_to conversation_path(@conversation, anchor: "message-#{@message.id}")
    else
      render "conversations/show"
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :attachment)
  end
end
