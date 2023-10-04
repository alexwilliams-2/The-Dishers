class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def show?
    return true
  end

  def new?
    return create?
  end

  def create?
    return true
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
