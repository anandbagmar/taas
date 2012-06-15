require "rubygems"
require File.join(File.dirname(__FILE__), '../..', 'lib', 'client', 'taas_client')
require "test/unit"
require "yaml"
require "mocha"
require "json"
require "shoulda-context"

include Client

class TaaSClientTest < Test::Unit::TestCase

  def test_execute_contract
    input_params = {:name => "taas"}
    output_params = {"id"=>1, "json_response"=>{}}
    taas_client = TaaSClient.new("http://localhost:4567/")

    uri = URI.parse("http://localhost:4567/")
    URI.stubs(:parse).with("http://localhost:4567/").returns(uri)

    http = Net::HTTP.new(uri.host, uri.port)
    Net::HTTP.stubs(:new).with(uri.host,uri.port).returns(http)
    stub_request = Net::HTTP::Post.new(uri.request_uri)
    Net::HTTP::Post.stubs(:new).with(uri.request_uri).returns(stub_request)

    stub_request.stubs(:set_form_data).with(input_params).returns(true)
    stub_request.stubs(:read_timeout=).with(1000*10000).returns(true)

    command_output = "This is command output"
    response = "<Taas command output start>#{command_output}<Taas command output ends>{\"id\":1,\"json_response\":{}}"
    http.stubs(:request).with(stub_request).returns(response)
    response.stubs(:body).returns(response)

    hash, output = taas_client.execute_contract(input_params)

    assert_equal output_params, hash
    assert_equal "#{command_output}", output

  end

  context "strip command output" do
    should " should strip the output form the json and return the command output" do
      taas_client = TaaSClient.new("http://localhost:4567/")
      output = "This is the command output"
      response_body = '<Taas command output start>This is the command output<Taas command output ends>{"passed":"false","json_output":{"listing_0":22893529,"live_sale_id":"12632","sale_name":"anand_-491983886"}}'

      striped_response, command_output = taas_client.strip_command_output(response_body)

      assert_equal output, command_output
      assert_equal '{"passed":"false","json_output":{"listing_0":22893529,"live_sale_id":"12632","sale_name":"anand_-491983886"}}', striped_response
    end
  end

end
