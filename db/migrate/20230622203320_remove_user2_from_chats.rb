class RemoveUser2FromChats < ActiveRecord::Migration[7.0]
  def change
    remove_column :chats, :user2_id, :references
  end
end
