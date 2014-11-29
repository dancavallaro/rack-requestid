require 'securerandom'

module Rack
  class RequestID

    REQUEST_ID_HEADER = 'X-Request-Id'
    REQUEST_ID_KEY = 'HTTP_X_REQUEST_ID'

    def initialize(app)
      @app = app
    end

    def call(env)
      if !env.key? REQUEST_ID_KEY
        request_id = SecureRandom.uuid
        env[REQUEST_ID_KEY] = request_id
      end

      status, headers, body = @app.call(env)
      headers[REQUEST_ID_HEADER] = env[REQUEST_ID_KEY]

      [status, headers, body]
    end

  end
end
