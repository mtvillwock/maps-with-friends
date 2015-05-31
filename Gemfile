source 'https://rubygems.org'
ruby '2.0.0'

# PostgreSQL driver
gem 'pg'

# Sinatra driver
gem 'sinatra'
gem 'sinatra-contrib'

# Use Thin for our web server
gem 'thin'

# activerecord ORM
gem 'activesupport'
gem 'activerecord'

gem 'rake'

gem 'bcrypt'

gem 'json'

# OAuth for Facebook
gem 'omniauth-facebook'

# HTTParty for use with OAuth
gem 'httparty'

# Rack CORS for AJAX cross server requests
gem 'rack-cors', :require => 'rack/cors'

# development server
gem 'shotgun'

group :test do
  gem 'shoulda-matchers'
  gem 'rack-test'
  gem 'capybara'
  gem 'selenium-webdriver'
end

group :test, :development do
  gem 'rspec'
  gem 'factory_girl'
  gem 'faker'
  gem 'dotenv'
  gem 'pry-debugger'
end

