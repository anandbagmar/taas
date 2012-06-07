require File.join(File.dirname(__FILE__), '../..', 'lib', 'server', 'helper', 'command_runner')
require "test/unit"
require "rubygems"
require "mocha"

include TaaS::CommandRunner

class CommandRunnerTest < Test::Unit::TestCase

  def test_execute_return_nil_for_nil_dir
    assert_nil execute(nil,"ls")
  end

  def test_execute_return_nil_for_nil_command
    assert_nil execute("/",nil)
  end

   def test_execute_runs_command
     output = `ls`
     assert_equal output, execute(Dir.pwd,"ls")
   end

   def test_execute_contract
     input_hash = {:id => 1, :name => "akash"}
     output_json = '{"status":"pass"}'
     TaaS::CommandRunner.stubs(:execute).with("/home", "bundle exec cucumber taas_id=1 taas_name=\"akash\"").returns(output_json)

     TaaS::CommandRunner.stubs(:create_params_string).with(input_hash).returns(" taas_id=1 taas_name=\"akash\"")

     assert_equal output_json, TaaS::CommandRunner.execute_contract("/home", "bundle exec cucumber", input_hash)

   end

   def test_create_params_string
     input_hash = {:id => 1, :name => "akash"}

     assert_equal " taas_name=akash taas_id=1 ", TaaS::CommandRunner.create_params_string(input_hash)
   end
end
