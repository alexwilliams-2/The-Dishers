class ChatChannel < ApplicationCable::Channel
  def subscribed
    chat = Chat.find(params[:id])
    stream_for chat
    rescue ActiveRecord::RecordNotFound
    reject
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end


end
