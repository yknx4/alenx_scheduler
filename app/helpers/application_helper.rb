module ApplicationHelper
  def without_tenant?
    return true unless request.subdomains.present?
    current_subdomain === 'www'
  end

  def current_subdomain
    request.subdomains[0]
  end

  def user_subdomain(user = nil)
    user ||= current_user
    user.tenant.subdomain
  end

  def policy_for_resource(symbol)
   default_policy symbol_to_class(symbol)
  end

  def default_policy(element)
    begin
      policy(element)
    rescue Pundit::NotDefinedError
      element = element.new if element.is_a?(Class)
      ApplicationPolicy.new(current_user, element)
    end
  end

  def symbol_to_class(symbol)
    symbol.to_s.singularize.camelize.constantize
  end

  def pry_me
    binding.pry
  end
end
