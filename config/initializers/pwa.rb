# frozen_string_literal: true

Pwa.configure do |config|
  # Define Progressive Web Apps for Rails apps
  # config.define_app 'Subdomain', ['subdomain.example.com',
  #                                 'subdomain.lvh.me:3000']
  config.define_app 'App', [ 'localhost:5000']
end
