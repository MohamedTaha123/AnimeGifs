# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
Dotenv::Railtie.load
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
    # Exception Handler
    config.exception_handler =
      { dev: false,
        db: nil,
        # Custom Exceptions
        custom_exceptions: {
          # 'ActionController::RoutingError' => :not_found # => example
        },

        # On default 5xx error page, social media links included
        social: {
          facebook: nil, # Facebook page name
          twitter: nil, # Twitter handle
          youtube: nil, # Youtube channel name / ID
          linkedin: nil, # LinkedIn name
          fusion: nil # FL Fusion handle
        },
        exceptions: {

          :all => {
            layout: 'exception', # define layout
            notification: true # (false by default)
            # action: ____, (this is general)
            # background: (can define custom background for exceptions layout if required)
          },
          404 => {
            layout: 'exception', # define layout
            notification: true # (false by default)
            # action: ____, (this is general)
            # background: (can define custom background for exceptions layout if required)
          },
          500 => {
            layout: 'exception', # define layout
            notification: true # (false by default)
            # action: ____, (this is general)
            # background: (can define custom background for exceptions layout if required)
          }
        } }
  end
end
