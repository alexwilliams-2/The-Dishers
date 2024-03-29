class MessagesController < ApplicationController
  def create
    @chat = Chat.find(params[:chat_id])


    if @chat
      authorize @chat
      @message = @chat.messages.new(message_params)
      @message.user = current_user
      @message.save
        ChatChannel.broadcast_to(
          @chat,
        message: render_to_string(partial: "messages/message", locals: {message: @message}),
        sender_id: @message.user.id
        )
        head :ok
      end

  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
