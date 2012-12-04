require_relative File.join('../..', 'lib', 'helper', 'contract')
require_relative File.join('../',"test_helper")

class ContractTest < Test::Unit::TestCase

  context "value_of" do
    should "return the value of the given property of the contract" do
      key, value = ["command","ls"]
      params_hash = {key => value, "dir" => "/home"}
      contract = Contract.new(params_hash)
      assert_equal  value,contract.value_of(key)
    end

    should "return nil if the given property is not present in the contract" do
      contract = Contract.new({})
      assert_nil contract.value_of("key")
    end
  end

  context "has_property?" do
    should "return true if the property is present in the contract" do
      key, value = ["command","ls"]
      params_hash = {key => value}
      contract = Contract.new(params_hash)
      assert contract.has_property?(key)
    end
    should "return false if the property is not present in the contract" do
      key, value = ["command","ls"]
      params_hash = {key => value}
      contract = Contract.new(params_hash)
      assert_false contract.has_property?("key")
    end
  end

  context "command" do
    should "return the parameter string replaced in the place of <taas_params> template" do
      command_template = "play <taas_params> test"
      parameter_string = "-Dorder_id=1 -Dname=s"
      contract_hash = {"dir" => "/home", "command" => command_template, "input_param_format" => "-Dkey=value", :input_params =>{:order_id => nil}, :output_params =>{}}
      parameter = {:order_id => 1, :name => "s"}
      contract = Contract.new(contract_hash)

      ParameterFactory.stubs(:generate_parameter_string).with("-Dkey=value",parameter).returns(parameter_string)

      assert_equal "play #{parameter_string} test",contract.command(parameter)
    end

    should "return the parameter string append to command if no <taas_params> template is specified" do
      command_template = "play test"
      parameter_string = "order_id=1 name=s"
      parameter = {:order_id => 1, :name => "s"}
      contract_hash = {"dir" => "/home", "command" => command_template, "input_param_format" => "key=value", :input_params =>{:order_id => nil}, :output_params =>{}}
      contract = Contract.new(contract_hash)

      ParameterFactory.stubs(:generate_parameter_string).with("key=value",parameter).returns(parameter_string)

      puts "*"*50
      assert_equal "#{command_template}#{parameter_string}",contract.command(parameter)
    end
  end
end