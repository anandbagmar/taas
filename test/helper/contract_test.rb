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
end