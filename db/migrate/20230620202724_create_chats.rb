class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.belongs_to :user1, foreign_key: { to_table: :users }
      t.belongs_to :user2, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
