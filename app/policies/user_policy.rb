class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? || own?
  end

  def delete?
    user.admin? || own?
  end
end
