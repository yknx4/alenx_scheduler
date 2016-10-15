class Admin < User

  def self.default_scope
    distinct.with_role :admin
  end

  def assign_default_role
    self.add_role(:admin) if self.roles.blank?
  end
end