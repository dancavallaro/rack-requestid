Gem::Specification.new do |s|
  s.name = 'rack-requestid'
  s.version = '0.1'
  s.summary = 'Middleware for generating request IDs.'
  s.description = 'Rack::RequestID is a Rack middleware for generating request IDs. It generates a request GUID for every request (if one was not already provided) and inserts the request ID as a response header.'
  s.author = 'Dan Cavallaro'
  s.email = 'dan.t.cavallaro@gmail.com'
  s.homepage = 'https://github.com/dancavallaro/rack-requestid'
  s.files = Dir['{lib/**/*}'] + %w{README.md rack-requestid.gemspec}

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rack'
end
