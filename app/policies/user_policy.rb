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

  def permitted_attributes
    [:email, :username, :password, :password_confirmation]
  end
end
