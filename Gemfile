# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.1"
gem "dotenv-rails", groups: %i[development test]
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 6.0.2", ">= 6.0.2.2"
# Use sqlite3 as the database for Active Record
# gem 'sqlite3', '~> 1.4'
# Use Puma as the app server
gem "puma", "~> 4.1"
# Use SCSS for stylesheets
gem "sass-rails", ">= 6"
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.7"
# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem "image_processing", "~> 1.2"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.2", require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
  gem "rspec-rails", "~> 4.0.0"
  gem "rubocop-faker"
  gem "rubocop-performance", "~> 1.6", require: false
  gem "rubocop-rspec", require: false
end

group :development do
  gem "annotate", git: "https://github.com/ctran/annotate_models.git"
  gem "better_errors"
  gem "binding_of_caller"
  gem "brakeman", "~> 4.8", ">= 4.8.1"
  gem "bullet"
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "web-console", ">= 3.3.0"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 2.15"
  gem "database_cleaner"
  gem "faker", git: "https://github.com/faker-ruby/faker.git", branch: "master"
  gem "rails-controller-testing"
  gem "selenium-webdriver"
  gem "shoulda-matchers"
  # Easy installation and use of web drivers to run system tests with browsers
  gem "webdrivers"
end

gem "activerecord-session_store"
gem "acts_as_follower", github: "tcocca/acts_as_follower", branch: "master"
gem "acts-as-taggable-on", "~> 6.0"
gem "acts_as_votable"
gem "administrate", github: "excid3/administrate", branch: "jumpstart"
gem "albino"
gem "bootstrap", "~> 4.3", ">= 4.3.1"
gem "bootstrap_notify", "~> 0.0.5"
gem "cable_ready", "~> 4.1"
gem "carrierwave", "~> 2.0"
gem "carrierwave-bombshelter"
gem "carrierwave-imageoptimizer"
gem "client_side_validations"
gem "client_side_validations-simple_form"
gem "coderay"
gem "devise", "~> 4.7", ">= 4.7.2"
gem "devise-bootstrapped", github: "excid3/devise-bootstrapped", branch: "bootstrap4"
gem "devise_invitable", "~> 2.0.0"
gem "devise_masquerade", "~> 1.2"
gem "font-awesome-sass", "~> 5.6", ">= 5.6.1"
gem "friendly_id", "~> 5.2", ">= 5.2.5"
gem "futurism", "~> 0.4.1"
gem "github_api"
gem "gravatar_image_tag", github: "mdeering/gravatar_image_tag"
gem "impressionist"
gem "mini_magick", "~> 4.9", ">= 4.9.2"
gem "name_of_person", "~> 1.1"
gem "omniauth-facebook", "~> 5.0"
gem "omniauth-github", "~> 1.3"
gem "omniauth-twitter", "~> 1.4"
gem "pg"
gem "pygments.rb"
gem "ransack", github: "activerecord-hackery/ransack"
gem "redcarpet", "~> 3.5"
gem "rmagick", "~> 4.1", ">= 4.1.2"
gem 'rouge', '~> 3.23'
gem "serviceworker-rails"
gem "sidekiq", "~> 6.0", ">= 6.0.3"
gem "simple_form", "~> 5.0", ">= 5.0.2"
gem "simple_form_fancy_uploads"
gem "sitemap_generator", "~> 6.0", ">= 6.0.1"
gem "skeptick"
gem "stimulus_reflex", "~> 3.2"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
gem "unread"
gem "valid_email2"
gem "whenever", require: false
gem "yaml_db"
