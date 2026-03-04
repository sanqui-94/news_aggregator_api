Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # In development this is your React dev server (Vite default port)
    # In production this will be your deployed frontend domain
    # The value comes from the environment — never hardcode origins
    origins ENV.fetch("FRONTEND_ORIGIN")

    resource "/graphql",
      headers: :any,
      methods: %i[post options],
      credentials: true

    resource "/graphql/subscriptions",
      headers: :any,
      methods: %i[get options],
      credentials: true
  end
end
