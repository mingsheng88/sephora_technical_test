RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation, except: %w(ar_internal_metadata))
    DatabaseCleaner.strategy = :transaction
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  # config.before(:suite) { Timecop.safe_mode = true }
  # config.after(:suite) { Timecop.safe_mode = false }
end
