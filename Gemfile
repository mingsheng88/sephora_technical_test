source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'awesome_print' # Make console more user friendly
gem 'ancestry' # Tree structure
gem 'jbuilder', '~> 2.5' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jsonapi-resources', '~> 0.9'
gem 'jsonapi-resources-matchers', '~> 1.0.0'
gem 'kaminari', '~> 0.17' # Use Kaminari for pagination
gem 'money-rails', '~> 1' # Use money-rails to manage money
gem 'pg', '~> 0.21' # Use PostgreSQL as the database for Active Record
gem 'puma', '~> 3.10' # Use Puma as the app server
gem 'rack-timeout', '~> 0.4' # Use Rack Timeout. Read more: https://github.com/heroku/rack-timeout
gem 'rails', '~> 5.1.3'
gem 'rack-cors', require: 'rack/cors'

group :development, :test do
  gem 'byebug', platform: :mri # Call 'byebug' anywhere in your code to drop into a debugger console
  gem 'database_cleaner'
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

# Allow factory girl and ffaker on production (only since it is a technical test)
gem 'factory_girl_rails'
gem 'ffaker'
