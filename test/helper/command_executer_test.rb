require File.join($PROJECT_ROOT, 'lib', 'helper', 'command_executer')
require File.join($PROJECT_ROOT, 'test',"test_helper")


class CommandExecuterTest < Test::Unit::TestCase
  context "execute_contract" do
    should "not execute the contract if dir is nil or empty" do
      assert_nil CommandExecuter.execute_command(nil,"echo 'Hello'")
      assert_nil CommandExecuter.execute_command("","echo 'Hello'")
    end

    should "not execute the contract if command is nil or empty" do
      assert_nil CommandExecuter.execute_command(Dir.pwd,nil)
      assert_nil CommandExecuter.execute_command(Dir.pwd,"")
    end

    should "return the executed command output for valid dir and command" do
      assert_equal "Hello\n",CommandExecuter.execute_command(Dir.pwd,"echo 'Hello'").unpack("U*").map{|c|c.chr}.join
    end
  end
end