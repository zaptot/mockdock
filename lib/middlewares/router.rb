module Middlewares
  class Router
    def initialize(app)
      @app = app
    end

    def call(env)
      route_result = @app.call(env)
    end

    def process_mock

    end
  end
end
