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
    return create
  end

  def create?
    return true
  end

  def edit?
    # return record.user == user
    true
  end

  def update?
    return edit
  end

  def destroy?
    return record.user == user
  end
end
