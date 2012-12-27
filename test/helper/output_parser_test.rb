require_relative File.join('../..', 'lib', 'helper', 'output_parser')
require_relative File.join('../',"test_helper")


class OutputParserTest < Test::Unit::TestCase
  context "parse_taas_output" do
    should "return TaaS specific parsed json TaaS from the output" do
      response_json = '"paas":"true","data":{}'
      output = "this is core output.<TaaS Response Start>#{response_json}<TaaS Response Complete>"

      assert_equal OutputParser.parse_taas_output(output),response_json
    end

    should "return nil if the output format is not correct" do
      response_json = '"paas":"true","data":{}'
      output = "this is core output.#{response_json}<TaaS Response Complete>"

      assert_nil OutputParser.parse_taas_output(output)
    end
  end

  context "parse server output" do
    should "return the parameter hash and command output from server dump" do
      output="this is dummy output"
      response_json = '{"paas":"true","data":{}}'
      server_response="<TaaS-Server-Response><Taas-Output>#{output}</TaaS-Output><TaaS-Json>#{response_json}</TaaS-Json></TaaS-Server-Response>"
      response_hash = JSON.parse(response_json)

      assert_equal [response_hash, output],OutputParser.parse_server_output(server_response)

    end

    should "return nil if server dump is not of taas output standard" do
      output="this is dummy output"
      response_json = '{"paas":"true","data":{}}'
      server_response_1="<TaaS-Server-Response>#{output}</TaaS-Output><TaaS-Json>#{response_json}</TaaS-Json></TaaS-Server-Response>"
      server_response_2="<TaaS-Server-Response><Taas-Output>#{output}<TaaS-Json>#{response_json}</TaaS-Json></TaaS-Server-Response>"
      server_response_3="<TaaS-Server-Response><Taas-Output>#{output}</TaaS-Output>#{response_json}</TaaS-Json></TaaS-Server-Response>"
      server_response_4="<TaaS-Server-Response><Taas-Output>#{output}</TaaS-Output><TaaS-Json>#{response_json}</TaaS-Server-Response>"
      server_response_5="<TaaS-Server-Response><Taas-Output>#{output}</TaaS-Output><TaaS-Json>yello</TaaS-Json></TaaS-Server-Response>"

      assert_nil OutputParser.parse_server_output(server_response_1)
      assert_nil OutputParser.parse_server_output(server_response_2)
      assert_nil OutputParser.parse_server_output(server_response_3)
      assert_nil OutputParser.parse_server_output(server_response_4)
      assert_nil OutputParser.parse_server_output(server_response_5)
    end
  end

  context "valid_server_response?" do

    should "return false if the response is not same as TaaS server template" do
      server_output = "<Taas-Output>Dummy output</TaaS-Output><TaaS-Json>dummy json</TaaS-Json></TaaS-Server-Response>"
      assert_false OutputParser.valid_server_response?(server_output)

      server_output = "<TaaS-Server-Response>Dummy output</TaaS-Output><TaaS-Json>dummy json</TaaS-Json></TaaS-Server-Response>"
      assert_false OutputParser.valid_server_response?(server_output)

      server_output = "<TaaS-Server-Response><Taas-Output>Dummy output<TaaS-Json>dummy json</TaaS-Json></TaaS-Server-Response>"
      assert_false OutputParser.valid_server_response?(server_output)

      server_output = "<TaaS-Server-Response><Taas-Output>Dummy output</TaaS-Output>dummy json</TaaS-Json></TaaS-Server-Response>"
      assert_false OutputParser.valid_server_response?(server_output)

      server_output = "<TaaS-Server-Response><Taas-Output>Dummy output</TaaS-Output><TaaS-Json>dummy json</TaaS-Server-Response>"
      assert_false OutputParser.valid_server_response?(server_output)

      server_output = "<TaaS-Server-Response><Taas-Output>Dummy output</TaaS-Output><TaaS-Json>dummy json</TaaS-Json>"
      assert_false OutputParser.valid_server_response?(server_output)
    end

    should "return true if the response is not same as TaaS server template" do
      server_output =  "<TaaS-Server-Response><Taas-Output>Dummy output</TaaS-Output><TaaS-Json>dummy json</TaaS-Json></TaaS-Server-Response>"
      assert OutputParser.valid_server_response?(server_output)
    end

  end
end


