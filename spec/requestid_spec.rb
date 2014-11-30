require 'yaml'

REQUEST_ID_HEADER = 'X-Request-Id'
REQUEST_ID_KEY = 'HTTP_X_REQUEST_ID'

TEST_REQUEST_ID = '00000000-0000-0000-0000-000000000000'

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
    response = request.get '/', REQUEST_ID_KEY => TEST_REQUEST_ID

    expect(get_id_from_response(response)).to eq(TEST_REQUEST_ID)
  end

  context "when header disabled" do
    let(:stack) { Rack::RequestID.new app, :include_response_header => false }

    it "should not insert response header" do
      response = request.get '/'

      expect(response.headers).not_to have_key(REQUEST_ID_HEADER)
    end
  end

  context "when using custom generator" do
    let(:stack) { Rack::RequestID.new app, :generator => lambda { TEST_REQUEST_ID } }

    it "should use correct request ID" do
      requestid = get_id_from_response request.get('/')

      expect(requestid).to eq(TEST_REQUEST_ID)
    end
  end

  def get_id_from_response(response)
    YAML.load(response.body)[REQUEST_ID_KEY]
  end

end
