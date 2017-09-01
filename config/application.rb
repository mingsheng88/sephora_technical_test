require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SephoraTechnicalTest
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.eager_load = true
    config.consider_all_requests_local = false

    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.api_only = true

    # Autoload
    autoload_paths = %w(
      app/resources
      app/jsonapi_formatters
      app_frontend
    )

    autoload_paths.each do |autoload_path|
      config.autoload_paths << Rails.root.join(autoload_path)
    end
  end
end
