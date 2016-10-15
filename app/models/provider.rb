class Provider < User

  def self.default_scope
    with_role :admin
  end

  def assign_default_role
    self.add_role(:provider) if self.roles.blank?
  end
end