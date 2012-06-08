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

CONTRACT = TaaS::ContractLoader.load_file(ARGV[0])
puts "CONTRACTS ARE #{CONTRACT.inspect}"

post "/contract" do
  content_type :json

  dir = CONTRACT["contracts"]["#{params[:contract_name]}"]["dir"]
  command = CONTRACT["contracts"]["#{params[:contract_name]}"]["command"]
  input_hash = params

  command_output = TaaS::CommandRunner.execute_contract(dir, command, input_hash)
  puts command_output

  data = "\"json_output\" : {#{TaaS::Server::Helper.parse_output(command_output)}}"
  puts data
  output_result = " \"passed\" : \"#{data.nil?}\""
  puts "{ #{output_result}, #{data}}"

  "{ #{output_result}, #{data}}"
end
