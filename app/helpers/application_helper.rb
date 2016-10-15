module ApplicationHelper
  def without_tenant?
    return true unless request.subdomains.present?
    request.subdomains[0] === 'www'
  end
end
