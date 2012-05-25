require "rubygems"
require "sinatra"
require File.expand_path("#{File.dirname(__FILE__)}/helper/helper.rb")
require File.expand_path("#{File.dirname(__FILE__)}/helper/bundle_exec.rb")

include Server::Helper
include BundleExec


get "/create_simple_live_sale/:name/:no_of_listing" do
   command_output = BundleExec.cucumber("features/spike/create_live_sale.feature WS_sale_name=#{params[:name]} WS_number_of_listing=#{params[:no_of_listing]}")
  "#{Server::Helper.parse_output(command_output)}"
end
