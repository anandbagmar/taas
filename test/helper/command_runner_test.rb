require File.join(File.dirname(__FILE__), '../..', 'lib', 'server', 'helper', 'command_runner')
require "test/unit"

include CommandRunner

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

end
