Rails.application.middleware.insert_after Rack::Sendfile, Middlewares::Router
