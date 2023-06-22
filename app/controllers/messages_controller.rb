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

      if @message.save
        ChatChannel.broadcast_to(
          @chat, render_to_string(partial: "message", locals: {message: @message})
        )
        head :ok
      else
        redirect_to chat_path(@chat), alert: 'Failed to send message'
      end
    else
      redirect_to businesses_path, alert: 'error'
    end

    @message = Message.new(message_params)
    @message.chat = @chat
    @message.user = current_user
    if @message.save
      redirect_to chat_path(@chat)
    else
      render "chat/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
