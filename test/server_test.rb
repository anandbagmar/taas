require File.join(Dir.pwd, 'lib', 'server')
require_relative "test_helper"

ENV['RACK_ENV']='test'

class ServerTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  context "post /contract" do

    should "return the pass attribute as false if the contract is not loaded" do
      contract_name = "Do Not Exists"
      file_name = "file_name"
      Contracts.stubs(:load).with(ARGV[0]).returns(file_name)
      Contracts.stubs(:is_empty?).returns(true)
      output = "Contract Name is either nil or not valid."
      response_json = '{"pass":"false","data":{}}'

      post "/contract", params = {:contract_name => "Do Not Exists"}

      assert last_response.ok?
      assert_true last_response.body.include?("<TaaS-Server-Response><Taas-Output>#{output}</TaaS-Output><TaaS-Json>#{response_json}</TaaS-Json></TaaS-Server-Response>")

    end
    should "return the pass attribute as false if the contract is loaded but requested contract is not valid" do
      contract_name = "Do Not Exists"
      file_name = "file_name"
      Contracts.stubs(:load).with(ARGV[0]).returns(file_name)
      Contracts.stubs(:is_empty?).returns(false)
      Contracts.stubs(:contains?).with(contract_name).returns(false)
      output = "Contract Name is either nil or not valid."
      response_json = '{"pass":"false","data":{}}'

      post "/contract", params = {:contract_name => "Do Not Exists"}

      assert last_response.ok?
      assert last_response.body.include?("<TaaS-Server-Response><Taas-Output>#{output}</TaaS-Output><TaaS-Json>#{response_json}</TaaS-Json></TaaS-Server-Response>")

    end

    should "not return pass attribute as false if the specificed contract do not exist but CONTACT_MANGER is initialized" do
      contract_name = "Do Not Exists"
      file_name = "file_name"
      Contracts.stubs(:load).with(ARGV[0]).returns(file_name)
      Contracts.stubs(:contains?).with(contract_name).returns(false)
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
      params = {"contract_name" => contract_name}
      contract = Contract.new({})
      file_name = "file_name"
      Contracts.stubs(:load).with(ARGV[0]).returns(file_name)
      Contracts.stubs(:is_empty?).returns(false)
      Contracts.stubs(:contains?).with(contract_name).returns(true)
      Contracts.stubs(:get_contract).with(contract_name).returns(contract)
      Contract.any_instance.stubs(:command).with(params).returns(command)
      Contract.any_instance.stubs(:value_of).with("dir").returns(dir)
      CommandExecuter.stubs(:execute_command).with(dir,command).returns(output)
      OutputParser.stubs(:parse_taas_output).with(output).returns(response_json)

      post "/contract", params

      assert last_response.ok?
      assert last_response.body.include?("<TaaS-Server-Response><Taas-Output>#{output}</TaaS-Output><TaaS-Json>#{response_json}</TaaS-Json></TaaS-Server-Response>")
    end
  end

end