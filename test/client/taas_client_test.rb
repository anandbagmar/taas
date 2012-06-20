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

    command_output = 'This is command /n /n /n output."'
    expected_hash = {:failed => "false", :json_response => {}}
    response = "{\"console_log\":\"<Taas command output start>#{command_output.gsub(/\"/,"\"")}<Taas command output ends>\",\"failed\":\"false\",\"json_response\":{}}"
    http.stubs(:request).with(stub_request).returns(response)
    response.stubs(:body).returns(response)

    hash, output = taas_client.execute_contract(input_params)

    assert_equal expected_hash, hash
    assert_equal command_output, output

  end

  context "result output hash and console log" do
    should "remove console output from the json and create hash for the output" do
      client = TaaSClient.new("http://localhost:4567/")
      hash_json_output = '"failed":"false","json_output":{"listing_0":22893529,"live_sale_id":"12632","sale_name":"anand_-491983886"}'
      hash = {:failed => "false" ,:json_output => {:listing_0 =>22893529, :live_sale_id => "12632",:sale_name =>"anand_-491983886"}}
      console_log = "This is the command /n /n output"
      response_body = "{\"console_log\":\"<Taas command output start>#{console_log}<Taas command output ends>\", #{hash_json_output}}"

      output_hash, output_log = client.result_output_hash_and_console_log(response_body)

      assert_equal output_hash,hash
      assert_equal console_log, output_log
    end
  end

end
