RSpec.configure do |config|
  config.before(:suite) do
    # Clean all tables to start
    DatabaseCleaner.clean_with :truncation
    # Use transactions for tests
    DatabaseCleaner.strategy = :transaction
    # Truncating doesn't drop schemas, ensure we're clean here, app *may not* exist
    # Create the default tenant for our tests
  end

  config.before(:each) do
    # Start transaction for this test
    DatabaseCleaner.start
    # Switch into the default tenant
  end

  config.after(:each) do
    # Reset tentant back to `public`
    Apartment::Tenant.reset
    # Rollback transaction
    DatabaseCleaner.clean
  end
end
