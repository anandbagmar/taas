require File.join(Dir.pwd, 'lib', 'server')
require "test/unit"
require "rack/test"
require "shoulda"
require "mocha"

ENV['RACK_ENV']='test'

class ServerTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  context "post /contract" do

    should "return the pass attribute as false if the contract is not loaded" do
      contract_name = "Do Not Exists"
      ContractManger.stubs(:contract_loaded?).returns(false)
      output = "Contract Name is either nil or not valid."
      response_json = '{"pass":"false","data":{}}'

      post "/contract", params = {:contract_name => "Do Not Exists"}

      assert last_response.ok?
      assert last_response.body.include?("<TaaS-Server-Response><Taas-Output>#{output}</TaaS-Output><TaaS-Json>#{response_json}</TaaS-Json></TaaS-Server-Response>")

    end
    should "return the pass attribute as false if the contract is loaded but requested contract is not valid" do
      contract_name = "Do Not Exists"
      ContractManger.stubs(:contract_loaded?).returns(true)
      ContractManger.stubs(:is_valid_contract?).with(contract_name).returns(false)
      output = "Contract Name is either nil or not valid."
      response_json = '{"pass":"false","data":{}}'

      post "/contract", params = {:contract_name => "Do Not Exists"}

      assert last_response.ok?
      assert last_response.body.include?("<TaaS-Server-Response><Taas-Output>#{output}</TaaS-Output><TaaS-Json>#{response_json}</TaaS-Json></TaaS-Server-Response>")

    end

    should "not return pass attribute as false if the specificed contract do not exist but CONTACT_MANGER is initialized" do
      contract_name = "Do Not Exists"
      ContractManger.stubs(:is_valid_contract?).with(contract_name).returns(false)
      output = "Contract Name is either nil or not valid."
      response_json = '{"pass":"false","data":{}}'

      post "/contract", params = {:contract_name => "Do Not Exists"}

      assert last_response.ok?
      assert last_response.body.include?("<TaaS-Server-Response><Taas-Output>#{output}</TaaS-Output><TaaS-Json>#{response_json}</TaaS-Json></TaaS-Server-Response>")
    end



    should "return the raw output from the executed contract" do
      command = "a"
      dir = "/taas/executiondir"
      response_json = '{"pass":"true","data":{"params1":"value1","params2":"value2"}'
      output = "All files and dir<TaaS Response Start>#{response_json}<TaaS Response Complete>"
      contract_name = "Contract Exists"
      ContractManger.stubs(:is_valid_contract?).with(contract_name).returns(true)
      ContractManger.stubs(:get_execution_attribute).with("command",contract_name).returns(command)
      ContractManger.stubs(:get_execution_attribute).with("dir",contract_name).returns(dir)
      CommandExecuter.stubs(:execute_command).with(command,dir).returns(output)
      OutputParser.stubs(:parse_taas_output).with(output).returns(response_json)

      post "/contract", params = {:contract_name => contract_name}

      assert last_response.ok?
      assert last_response.body.include?("<TaaS-Server-Response><Taas-Output>#{output}</TaaS-Output><TaaS-Json>#{response_json}</TaaS-Json></TaaS-Server-Response>")
    end
  end

end