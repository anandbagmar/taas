require File.join(File.dirname(__FILE__), '../..', 'lib', 'server', 'helper', 'helper')
require "test/unit"

include Server::Helper


class ServerHelperTest < Test::Unit::TestCase

  def test_extract_output
    command_output = 'This is the command output <TaaS Response Start>{"key": "value"}<TaaS Response Completed> from the command runner'
    expected_output = '<TaaS Response Start>{"key": "value"}<TaaS Response Completed>'

    assert_equal expected_output, extract_output(command_output)
  end

  def test_strip_brackets
    string = '{"key": "value"}'

    assert_equal '"key": "value"', strip_brackets(string)
  end

  def test_strip_output_tags
    output = '<TaaS Response Start>{"key": "value"}<TaaS Response Completed>'

    assert_equal '{"key": "value"}', strip_output_tags(output)
  end

  def test_parse_output
    command_output = 'This is the command output <TaaS Response Start>{"key": "value"}<TaaS Response Completed> from the command runner'

    assert_equal '"key": "value"', parse_output(command_output)
  end
end
