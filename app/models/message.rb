class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  def sender?(a_user)
    user.id == a_user.id
  end
end
