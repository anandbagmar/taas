require_relative File.join('../..', 'lib', 'helper', 'output_parser')
require "test/unit"
require "mocha"
require "shoulda"

class OutputParserTest < Test::Unit::TestCase
  context "parse_taas_output" do
    should "return TaaS specific parsed json TaaS from the output" do
      response_json = '"paas":"true","data":{}'
      output = "this is core output.<TaaS Response Start>#{response_json}<TaaS Response Complete>"

      assert_equal OutputParser.parse_taas_output(output).first.first,response_json
    end
  end
end


