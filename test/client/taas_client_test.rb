require "rubygems"
require File.join(File.dirname(__FILE__), '../..', 'lib', 'client', 'taas_client')
require "test/unit"
require "yaml"
require "mocha"
require "json"

include TaaS

class TaaSClientTest < Test::Unit::TestCase

  def test_execute_contract
    input_params = {:name => "taas"}
    output_params = {"id"=>1}
    taas_client = TaaSClient.new("http://localhost:4567/")

    uri = URI.parse("http://localhost:4567/")
    URI.stubs(:parse).with("http://localhost:4567/").returns(uri)

    http = Net::HTTP.new(uri.host, uri.port)
    Net::HTTP.stubs(:new).with(uri.host,uri.port).returns(http)
    stub_request = Net::HTTP::Post.new(uri.request_uri)
    Net::HTTP::Post.stubs(:new).with(uri.request_uri).returns(stub_request)

    stub_request.stubs(:set_form_data).with(input_params).returns(true)
    stub_request.stubs(:read_timeout=).with(1000*10000).returns(true)

    response = "{\"id\":1}"
    http.stubs(:request).with(stub_request).returns(response)
    response.stubs(:body).returns(response)


    assert_equal output_params, taas_client.execute_contract("http://localhost:4567/", input_params)

  end


end
