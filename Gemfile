source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# gem 'clockwork', '~> 2.0' # Use Clockwork for recurring background tasks without needing cron
# gem 'redis-rails', '~> 5.0' # Use Redis Rails to set up a Redis backed Cache and / or Session
# gem 'sidekiq', '~> 5.0' # Use Sidekiq as a background job processor through Active Job
gem 'awesome_print' # Make console more user friendly
gem 'acts_as_tree', '~> 2.6' # Tree structure
gem 'bootstrap-sass', '~> 3.3' # Use Bootstrap SASS for Bootstrap support
gem 'font-awesome-rails', '~> 4.7' # Use Font Awesome Rails for Font Awesome icons
gem 'jbuilder', '~> 2.5' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jquery-rails', '~> 4.3' # Use jQuery as the JavaScript library
gem 'jsonapi-resources', '~> 0.9'
gem 'jsonapi-resources-matchers', '~> 1.0.0'
gem 'kaminari', '~> 0.17' # Use Kaminari for pagination
gem 'money-rails', '~> 1' # Use money-rails to manage money
gem 'pg', '~> 0.21' # Use PostgreSQL as the database for Active Record
gem 'puma', '~> 3.10' # Use Puma as the app server
gem 'rack-timeout', '~> 0.4' # Use Rack Timeout. Read more: https://github.com/heroku/rack-timeout
gem 'rails', '~> 5.1.3'
gem 'sass-rails', '~> 5.0' # Use SCSS for stylesheets
gem 'turbolinks', '~> 5' # Use Turbolinks. Read more: https://github.com/turbolinks/turbolinks
gem 'uglifier', '>= 1.3.0' # Use Uglifier as the compressor for JavaScript assets
gem 'rack-cors', require: 'rack/cors'

group :development, :test do
  # End to end testing of your rails apps (Rails 5.1+ supports this)
  # gem 'capybara', '~> 2.13'
  # gem 'selenium-webdriver'
  gem 'byebug', platform: :mri # Call 'byebug' anywhere in your code to drop into a debugger console
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'pry-byebug' # debugger navigation commands
  gem 'rspec-rails'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'listen', '>= 3.0.5', '< 3.2' # Get notified of file changes. Read more: https://github.com/guard/listen
  gem 'rack-mini-profiler', '~> 0.10' # Enable a debug toolbar to help profile your application
  gem 'spring' # Use Spring. Read more: https://github.com/rails/spring
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '~> 3.3.0' # Access an IRB console on exception pages or by using <%= console %>
end

gem 'tzinfo-data' # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
