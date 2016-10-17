class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? or is_own?
  end

  def delete?
    user.admin? or is_own?
  end
end