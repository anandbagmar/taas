require "rubygems"
require "sinatra"
require File.expand_path("#{File.dirname(__FILE__)}/helper/helper.rb")
require File.expand_path("#{File.dirname(__FILE__)}/helper/command_runner.rb")

include Server::Helper
include CommandRunner


get "/create_simple_live_sale/:name/:no_of_listing" do
   command_output = CommandRunner.execute("/home/tworker/work/livesale-automation","bundle exec cucumber features/spike/create_live_sale.feature WS_sale_name=#{params[:name]} WS_number_of_listing=#{params[:no_of_listing]}")
  data = "\"json_output\" : [#{Server::Helper.parse_output(command_output)}]"
  output_result = " \"passed\" : \"#{data.nil?}\", \"raw_output\": \"#{command_output}\""
  "{ #{output_result}, #{data}}"
end
