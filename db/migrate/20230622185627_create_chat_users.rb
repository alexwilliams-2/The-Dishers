class CreateChatUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_users do |t|

      t.timestamps
    end
  end
end
