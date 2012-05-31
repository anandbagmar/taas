require "rubygems"
require "sinatra"
require File.expand_path("#{File.dirname(__FILE__)}/helper/helper.rb")
require File.expand_path("#{File.dirname(__FILE__)}/helper/command_runner.rb")

include TaaS::Server::Helper
include TaaS::CommandRunner

puts "Starting the TaaS server at http://localhost:4567"

get "/create_simple_live_sale/:name/:no_of_listing" do
   command_output = TaaS::CommandRunner.execute("/home/tworker/work/livesale-automation","bundle exec cucumber --tags @create_live_sale taas_sale_name=#{params[:name]} taas_number_of_listing=#{params[:no_of_listing]}")
  data = "\"json_output\" : [#{TaaS::Server::Helper.parse_output(command_output)}]"
  output_result = " \"passed\" : \"#{data.nil?}\", \"raw_output\": \"#{command_output}\""
  "{ #{output_result}, #{data}}"
end
