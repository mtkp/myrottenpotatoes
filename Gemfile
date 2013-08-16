source 'https://rubygems.org'

ruby '2.0.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'anjlab-bootstrap-rails', :require => 'bootstrap-rails',
                              :github => 'anjlab/bootstrap-rails',
                              :branch => '3.0.0'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'haml'
gem 'pg'
gem 'ruby-tmdb3'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook'

group :test do
  gem 'cucumber-rails', git: 'https://github.com/cucumber/cucumber-rails.git', branch: 'master_rails4_test', require: false
  gem 'simplecov', require: false
  gem 'webmock'
end

group :test, :development do
  gem 'cucumber-rails-training-wheels'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'launchy'
  gem 'rspec-rails', '~> 2.0'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'factory_girl_rails'
  gem 'metric_fu', require: false
end

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :production do
  gem 'rails_12factor'
end
# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
