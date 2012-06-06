require "rubygems"
require File.join(File.dirname(__FILE__), '../..', 'lib', 'server', 'helper', 'contract_loader')
require "test/unit"
require "mocha"

include TaaS::ContractLoader

class ContractLoaderTest < Test::Unit::TestCase

  def test_contract_loader_return_hash_of_yaml_file
    hash = {"contracts"=>{
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

    Dir.stubs(:pwd).returns("/home/akash/taas/lib/server")


    assert_equal hash, TaaS::ContractLoader.load_file("contracts.yaml")
  end

  def test_contract_loader_return_nil_in_case_of_error
    Dir.stubs(:pwd).returns("/home/akash/taas/lib/server")

    assert_nil TaaS::ContractLoader.load_file("c.yaml")
  end
end
