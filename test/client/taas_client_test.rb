require "rubygems"
require File.join(File.dirname(__FILE__), '../..', 'lib', 'client', 'taas_client')
require "test/unit"
require "yaml"
require "mocha"
require "json"

class TaaSClientTest < Test::Unit::TestCase

  def test_execute_contract
    input_params = {:name => "taas"}
    output_params = {"id"=>1}

    taas_client = TaaSClient.new("http://localhost:4567/")

    uri = URI.parse("http://localhost:4567/")
    URI.stubs(:parse).with("http://localhost:4567/").returns(uri)

    response = "<!DOCTYPE html>\n<html>\n<head>\n  <style type=\"text/css\">\n  body { text-align:center;font-family:helvetica,arial;font-size:22px;\n    color:#888;margin:20px}\n  #c {margin:0 auto;width:500px;text-align:left}\n  </style>\n</head>\n<body>{\"id\":1}</body>\n</html>\n"


    Net::HTTP.stubs(:post_form).with(uri, input_params).returns(Net::HTTPFound)
    Net::HTTPFound.stubs(:body).returns(response)

    assert_equal output_params, taas_client.execute_contract("http://localhost:4567/", input_params)

  end


end
