class MessagesController < ApplicationController
  # def show
  #   @chat = Chat.find(params[:id])
  # end

  def create
    @chat = Chat.find(params[:chat_id])

    # @message = chat.messages.create(user: current_user, content: params[:content])
    if @chat
      @message = @chat.messages.new(message_params)
      # authorize @message
      @message.user = current_user

      @message.save
        ChatChannel.broadcast_to(
          @chat, render_to_string(partial: "messages/message", locals: {message: @message})
        )
        head :ok
      end

  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
