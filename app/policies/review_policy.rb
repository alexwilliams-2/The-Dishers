class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def show?
    return true
  end

  def new?
    return create?
  end

  def create?
    user.present?
  end

  def edit?
    user.present? && record.user == user
  end

  def update?
    return edit?
  end

  def destroy?
    user.present? && record.user == user
  end
end
