class RemoveUser1FromChats < ActiveRecord::Migration[7.0]
  def change
    remove_column :chats, :user1_id, :references
  end
end
