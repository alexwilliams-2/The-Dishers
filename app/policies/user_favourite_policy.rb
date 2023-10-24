class UserFavouritePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def show?
    user.present? && record.user == user
  end

  def new?
    return create?
  end

  def create?
    user.present?
  end

  def toggle_like?
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
