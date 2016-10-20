class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? || is_own?
  end

  def delete?
    user.admin? || is_own?
  end
end
