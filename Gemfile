source 'https://rubygems.org'

gem 'rails', '3.2.6'
gem 'sqlite3'
gem 'devise'
gem 'cancan'
gem 'jquery-rails'
gem 'anjlab-bootstrap-rails', '>= 2.0', :require => 'bootstrap-rails'
gem "draper"

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem "pry"
  gem "pry-rails"
  gem "quiet_assets"
  gem "thin"
  gem 'annotate', '~> 2.4.1.beta'
end

group :test, :development do
  gem "rspec-rails", '~> 2.11.0'
end

group :test do
  gem "cucumber-rails"
  gem "database_cleaner"
  gem "spork"
  gem "guard-rspec"
  gem "guard-livereload"
  gem "guard-cucumber"
  gem "guard-spork"
  gem "email_spec"
  gem "factory_girl_rails"
  gem "cover_me", '>= 1.2.0'
end

group :production do
  gem 'therubyracer'
end
