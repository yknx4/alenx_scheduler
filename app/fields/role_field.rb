require "administrate/field/base"

class RoleField < Administrate::Field::Select
  ROLES = %w(admin user provider)

  private
  def collection
    ROLES
  end
end
