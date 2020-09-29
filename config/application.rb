# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
# FIXME: fix it for heroku deployment
if %w[development test].include? ENV["RAILS_ENV"]
  Dotenv::Railtie.load
end

module MyApi
  class Application < Rails::Application
    # Expose our application's helpers to Administrate
    config.to_prepare do
      Administrate::ApplicationController.helper MyApi::Application.helpers
    end
    config.active_job.queue_adapter = :sidekiq

    config.application_name = Rails.application.class.module_parent_name
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.middleware.insert_after ActionDispatch::Static, Rack::Deflater
  end
end
