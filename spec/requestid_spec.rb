require 'yaml'

REQUEST_ID_HEADER = 'X-Request-Id'
REQUEST_ID_KEY = 'HTTP_X_REQUEST_ID'

describe Rack::RequestID do

  let(:app) { lambda { |env| [200, {}, [env.to_yaml]] } }
  let(:stack) { Rack::RequestID.new app }
  let(:request) { Rack::MockRequest.new stack }

  it "should generate random request IDs" do
    first_requestid = get_id_from_response request.get('/')
    second_requestid = get_id_from_response request.get('/')

    expect(first_requestid).not_to eq(second_requestid)
  end

  it "should return the request ID in the response headers" do
    response = request.get '/'
    requestid = get_id_from_response(response)

    expect(response.headers[REQUEST_ID_HEADER]).to eq(requestid)
  end

  it "should not overwrite existing request ID" do
    response = request.get '/', REQUEST_ID_KEY => '00000000-0000-0000-0000-000000000000'

    expect(get_id_from_response(response)).to eq('00000000-0000-0000-0000-000000000000')
  end

  def get_id_from_response(response)
    YAML.load(response.body)[REQUEST_ID_KEY]
  end

end
