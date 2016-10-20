class UserValidator < ActiveModel::Validator
  def validate(user)
    @user = user
    validate_tenant_is_not_taken if @user.admin?
    validate_tenant_is_active unless @user.admin?
  end

  private

  def validate_tenant_is_not_taken
    @user.errors.add :tenant, 'already exists.' if subdomain_taken? and @user.tenant.blank?
  end

  def subdomain_taken?
    Tenant.where(subdomain: @user.subdomain).exists?
  end

  def validate_tenant_is_active
    return if @user.errors[:tenant].present? or Apartment::Tenant.current == @user.subdomain
    @user.errors.add :tenant, 'has to be active'
  end
end
