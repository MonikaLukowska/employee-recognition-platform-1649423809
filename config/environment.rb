# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  user_name: 'apikey',
  password: Rails.application.credentials.dig(:sendgrid, :api_key),
  domain: 'https://monkaemployees.herokuapp.com/',
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}

ActionMailer::Base.raise_delivery_errors = true
