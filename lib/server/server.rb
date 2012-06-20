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

  output_hash = TaaS::Server::Helper.parse_output(command_output).gsub(/\n/,"")
  data = "\"json_output\":{#{output_hash}}"
  puts data
  output_result = "\"failed\":\"#{output_hash.empty?}\""
  puts "{ #{output_result}, #{data}}"

  "<Taas command output start>#{command_output}<Taas command output ends>{#{output_result},#{data}}"
end

get "/" do
  "Contract is -> #{CONTRACT.inspect}"
end
