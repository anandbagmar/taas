require File.join(Dir.pwd, 'lib', 'taas_client')
require_relative "test_helper"


class TaaSClientTest < Test::Unit::TestCase

  context "execute_contract" do
    setup do
      @taas_client = TaaSClient.new("http://taas-url.com/")
      @params = {:contract_name => "create_xyz", :params  => {:params_one => "one", :params_n => "params n"}}
      @response_json = '"pass":"true","data":{}'
      @hash = {:pass => true, :data => {}}
      @output="This is a Dummy Output"
      @server_output = "<TaaS-Server-Response><Taas-Output>#{@output}</TaaS-Output><TaaS-Json>#{@response_json}</TaaS-Json></TaaS-Server-Response>"
    end
    should "return hash and command output of server if failed is false" do
      @taas_client.stubs(:request_taas_server).with(@params).returns(@server_output)
      OutputParser.stubs(:valid_server_response?).with(@server_output).returns(true)
      values = lambda {return @output,@hash}
      OutputParser.stubs(:parse_server_output).with(@server_output).returns(values.call)

      command_output, response_hash = @taas_client.execute_contract(@params)

      assert_equal command_output,@output
      assert_equal response_hash, @hash
    end


    should "raise an error if validate_server returns false" do
      @taas_client.stubs(:request_taas_server).with(@params).returns(@server_output)
      OutputParser.stubs(:valid_server_response?).with(@server_output).returns(false)

      assert_raise do
        @taas_client.execute_contract(@params)
      end
    end
  end



  context "request_taas_server" do
    should "return the body of the taas server response" do
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

        assert response,taas_client.request_taas_server(input_params)
    end
  end
end
