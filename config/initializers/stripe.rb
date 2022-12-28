Rails.application.configure do
  config.stripe.secret_key = Rails.application.credentials.dig(:stripe, :STRIPE_SECRET_KEY)
  config.stripe.publishable_key = Rails.application.credentials.dig(:stripe, :STRIPE_PUBLISHABLE_KEY)
end