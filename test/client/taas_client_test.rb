require File.join(File.dirname(__FILE__), '../..', 'lib', 'client', 'taas_client')
require "test/unit"
require "yaml"


class TaaSClientTest < Test::Unit::TestCase

  def self.start_test_server
    puts "Starting TaaS test Server"
    server_path = "#{File.dirname(__FILE__)}/../server/math_service.rb"
    eval("ruby server_path")
  end

  def test_configure_return_nil_for_nil_url
    assert_nil TaaS.configure(nil, 10)
  end

  def test_execute_return_nil_for_nil_contractName
    TaaS.configure("http://localhost:4567", 10)
    assert_nil TaaS.execute(nil, {})
  end

  #def test_execute_contract_create_live_sale
  #  yaml = YAML.load_file("#{File.dirname(__FILE__)}/resources/test_contracts.yaml")
  #  yamlObject = yaml.to_hash
  #
  #  contract_name = "create_simple_live_sale"
  #  input_params = yamlObject["Contracts"]["Contract"]["create_simple_live_sale"]["Input_Params"]
  #  time_out = yamlObject["Contracts"]["Contract"]["create_simple_live_sale"]["timeout_in_seconds"]
  #
  #  TaaS.configure("http://localhost:4567",time_out)
  #
  #  assert_not_nil TaaS.execute(contract_name, input_params)
  #end

  def test_add_contract_with_numbers
    yaml = YAML.load_file("#{File.dirname(__FILE__)}/../resources/test_contracts.yaml")
    yamlObject = yaml.to_hash
    puts yamlObject

    contract_name = "add_two_numbers"
    input_params = yamlObject["contracts"]["add_two_numbers"]["input_params"]
    timeout_in_seconds = yamlObject["contracts"]["add_two_numbers"]["timeout_in_seconds"]

    TaaS.configure("http://localhost:4567", timeout_in_seconds)
    assert_not_nil TaaS.execute(contract_name, input_params)
  end

  def test_add_contract_with_strings
    yaml = YAML.load_file("#{File.dirname(__FILE__)}/../resources/test_contracts.yaml")
    yamlObject = yaml.to_hash
    puts yamlObject

    contract_name = "add_two_numbers"
    input_params = yamlObject["contracts"]["add_two_invalid_numbers"]["input_params"]
    timeout_in_seconds = yamlObject["contracts"]["add_two_invalid_numbers"]["timeout_in_seconds"]

    TaaS.configure("http://localhost:4567", timeout_in_seconds)
    assert_not_nil TaaS.execute(contract_name, input_params)
  end
end