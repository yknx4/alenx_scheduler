module TenantHelper
  def tenant_biz
    Tenant.current.organization.schedule.biz
  end
end
