class AddChatToChatUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :chat_users, :chat, null: false, foreign_key: true
  end
end
