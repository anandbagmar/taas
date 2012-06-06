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


get "/contract/:contract_name" do
  TaaS::CommandRunner(CONTRACT[params[:contract_name][:dir], CONTRACT[params[:contract_name][:command]])
end
