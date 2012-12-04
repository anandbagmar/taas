require_relative File.join('../..', 'lib', 'helper', 'parameter_factory')
require_relative File.join('../',"test_helper")

class ParameterFactoryTest < Test::Unit::TestCase

  context "generate_parameter_string" do
    should "create command line params string in given template" do
      template ="-Dkey=value"
      params_hash = {:order_id => 1, :name => "s"}
      expected_string = " -Dorder_id=1 -Dname=s"

      generated_string = ParameterFactory.generate_parameter_string(template,params_hash)

      assert_equal generated_string,expected_string
    end

    should "create command line in params in key=value template if no template is specified" do
      params_hash = {:order_id => 1, :name => "s"}
      expected_string = " order_id=1 name=s"

      generated_string = ParameterFactory.generate_parameter_string(nil,params_hash)

      assert_equal generated_string,expected_string

    end
  end
end
