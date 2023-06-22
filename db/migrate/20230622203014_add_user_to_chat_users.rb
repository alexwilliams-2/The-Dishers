class AddUserToChatUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :chat_users, :user, null: false, foreign_key: true
  end
end
