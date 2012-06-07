require "rubygems"
require "sinatra"
require "yaml"

require File.expand_path("#{File.dirname(__FILE__)}/helper/helper.rb")
require File.expand_path("#{File.dirname(__FILE__)}/helper/command_runner.rb")
require File.expand_path("#{File.dirname(__FILE__)}/helper/contract_loader.rb")

include TaaS::Server::Helper
include TaaS::CommandRunner
include TaaS::ContractLoader

puts "Starting the TaaS server at http://localhost:4567"

CONTRACT = TaaS::ContractLoader.load_file("contracts.yaml")
puts "CONTRACTS ARE #{CONTRACT.inspect}"

post "/contract" do
  dir = CONTRACT["contracts"]["#{params[:contract_name]}"]["dir"]
  command = CONTRACT["contracts"]["#{params[:contract_name]}"]["command"]
  input_hash = params


  command_output = TaaS::CommandRunner.execute_contract(dir, command, input_hash)
  puts command_output

  data = "\"json_output\" : [#{Server::Helper.parse_output(command_output)}]"
  output_result = " \"passed\" : \"#{data.nil?}\""
  "{ #{output_result}, #{data}}"

end
