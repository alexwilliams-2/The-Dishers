class ChatPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def show?
    return user.present?
  end

  def new?
    return create?
  end

  def create?
    user.present?
  end

end
