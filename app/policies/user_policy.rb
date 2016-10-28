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

  def destroy?
    user.admin? || own?
  end

  def permitted_attributes
    [:email, :username, :password, :password_confirmation] + admin_only_attributes
  end

  def admin_only_attributes
    return [] unless user.admin?
    [:role]
  end
end
