# Rack::RequestID, a Rack middleware for generating request IDs

This is a simple middleware that will generate a request GUID if one was not 
already provided by the client or platform. 

A request ID can be specified in the request (by the client or platform) by
setting the `X-Request-Id` header, and it will be available to other middleware
via the `HTTP_X_REQUEST_ID` key in the Rack environment hash. If a request ID
was not provided, Rack::RequestID will generate one and insert it into the Rack
environment. It will also insert the request ID into the `X-Request-Id` header
of the response. 

## Configuration

To use Rack::RequestID, add the following to your Gemfile:

	gem 'rack-requestid', :github => 'dancavallaro/rack-requestid'

Then in `config.ru`:

	use Rack::RequestID

Use Rack::RequestID before any middleware that needs a request ID. 

There are a few options you can pass in:

  * `:include_response_header` determines whether to include the request ID in a response header.
  * `:generator` can be specified to provide a custom request ID generator.

If you want to modify the options used, simply do:

    use Rack::RequestID, :include_response_header => false, :generator => lambda { "#{Time.now.getutc.to_i}" }
