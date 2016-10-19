RSpec.shared_context 'default_tenant', :shared_context => :metadata do
  let(:tenant) { create(:tenant) }

  before(:each) do
    tenant.switch!
  end

  after(:each) do
    Apartment::Tenant.reset
  end
end