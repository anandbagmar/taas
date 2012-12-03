require_relative File.join('../..', 'lib', 'helper', 'contracts')
require_relative File.join('../',"test_helper")


class ContractsTest < Test::Unit::TestCase

  CONTRACT_HASH = {"contracts"=>{
      "create_live_sale"=>
          {"command"=>"bundle exec cucumber",
           "dir"=>"/home/tworker/work/livesale-automation",
           "input_params"=>{"name"=>nil, "no_of_listing"=>nil},
           "timeout_in_seconds"=>100,
           "output_params"=>{"live_sale_id"=>nil}},
      "end_live_sale"=>
          {"command"=>"bundle exec cucumber",
           "dir"=>"/home/tworker/work/livesale-automation",
           "input_params"=>{"live_sale_id"=>nil},
           "timeout_in_seconds"=>100,
           "output_params"=>{"actual_end_time"=>nil}}}}

  context "contract_loaded" do
    should "return true if contract file is present" do
      contract_file_absolute_path = "a1/a2"
      YAML.stubs(:load_file).with(contract_file_absolute_path).returns(CONTRACT_HASH)

      Contracts.load_contract(contract_file_absolute_path)

      assert Contracts.contract_loaded?
    end

    should "not contract if contract file is not present" do
      contract_file_absolute_path = "a1/a2"
      YAML.stubs(:load_file).with(contract_file_absolute_path).returns({})

      Contracts.load_contract(contract_file_absolute_path)

      assert_false Contracts.contract_loaded?
    end

    should "raise execption if empty or nil contract file is passesd" do
      assert_raise do
        Contracts.load_contract(nil)
      end
      assert_raise do
        Contracts.load_contract("")
      end

    end
  end

  context "get_execution_attribute" do
     setup {
       @contract_file_absolute_path = "a1/a2"
       @contract_name = :create_live_sale
     }
      should "return the attribute specific to the contract" do
        YAML.stubs(:load_file).with(@contract_file_absolute_path).returns(CONTRACT_HASH)
        Contracts.load_contract(@contract_file_absolute_path)

        ["command","dir","input_params"].each do |attribute|
          assert_equal CONTRACT_HASH["contracts"][@contract_name.to_s][attribute],Contracts.get_execution_attribute(attribute,@contract_name)
        end
      end

      should "return the nil for any attribute if contract file not present" do
        YAML.stubs(:load_file).with(@contract_file_absolute_path).returns({})
        Contracts.load_contract(@contract_file_absolute_path)

        assert_nil Contracts.get_execution_attribute("command",@contract_name)
      end
  end

  context "is_valid_contract?" do
    setup {
      @contract_file_absolute_path = "a1/a2"
      @contract_name = :create_live_sale
      YAML.stubs(:load_file).with(@contract_file_absolute_path).returns(CONTRACT_HASH)
      Contracts.load_contract(@contract_file_absolute_path)
    }
    should "return true if requested contract is present" do
       assert Contracts.is_valid_contract?("create_live_sale")
    end
    should "return false if requested contract is not present" do
      assert_false Contracts.is_valid_contract?("dummy_contract")
    end
  end

end