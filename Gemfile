source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
gem 'active_model_serializers', '~> 0.10.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'activerecord-precount', '~> 0.6.1'
gem 'goldiloader', '~> 0.0.10'

gem 'sidekiq', '~> 4.2.2'

gem 'apartment', '~> 1.2.0'

# Auth - Login
gem 'pundit', '~> 1.1.0'
gem 'devise', '~> 4.2.0'
gem 'rolify', '~> 5.1.0'
gem 'devise_token_auth', '~> 0.1.39'
gem 'omniauth-google-oauth2', '~> 0.4.1'

# Admin

gem 'haml', '~> 4.0.5'
gem 'haml-rails', '~> 0.9'

gem 'administrate', git: 'https://github.com/yknx4/administrate', branch: 'rails5'
gem 'bourbon', '~> 5.0.0.beta.5'

gem 'biz', '~> 1.6.0'

gem 'codeclimate-test-reporter', group: :test, require: nil
gem 'rollbar', '~> 2.13.3'

gem 'jsonapi', '~> 0.1.1.beta6'
gem 'memoist', '~> 0.15.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'bullet'
  gem 'active_record_query_trace'
  gem 'rubocop', require: false
  gem 'sql_queries_count', '= 0.0.1'
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl_rails', '~> 4.7.0'
  gem 'faker', '~> 1.6.6'
  gem 'database_cleaner', '~> 1.5.3'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'eslint-rails'
  gem 'better_errors'
  gem 'binding_of_caller'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
