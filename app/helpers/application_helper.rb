module ApplicationHelper
  def without_tenant?
    return true unless request.subdomains.present?
    current_subdomain === 'www'
  end
  def current_subdomain
    request.subdomains[0]
  end
end
