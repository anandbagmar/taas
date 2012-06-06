require "rubygems"
require "sinatra"
require "yaml"
require "peach"
require File.expand_path("#{File.dirname(__FILE__)}/helper/helper.rb")
require File.expand_path("#{File.dirname(__FILE__)}/helper/command_runner.rb")

include TaaS::Server::Helper
include TaaS::CommandRunner

puts "Starting the TaaS server at http://localhost:4567"


#get "/#{method_name}/:name/:no_of_listing" do
#
#  yaml = YAML.load_file("#{File.dirname(__FILE__)}/TestFramework/contracts.yaml")
#  frameworkSettings = yaml.to_hash
#  command_output = TaaS::CommandRunner.execute(frameworkSettings["Contracts"]["Contract"]["create_simple_live_sale"]["Dir"],frameworkSettings["Contracts"]["Contract"]["create_simple_live_sale"]["Command"])
#  #command_output = TaaS::CommandRunner.execute("/home/tworker/work/livesale-automation","bundle exec cucumber --tags @create_live_sale taas_sale_name=#{params[:name]} taas_number_of_listing=#{params[:no_of_listing]}")
#
#  data = "\"json_output\" : [#{TaaS::Server::Helper.parse_output(command_output)}]"
#  output_result = " \"passed\" : \"#{data.nil?}\", \"raw_output\": \"#{command_output}\""
#  "{ #{output_result}, #{data}}"
#end

yaml = YAML.load_file("#{File.pwd}/#{ARGV[0]}")
contracts = yaml.to_hash
signature = ""
cmd = ""

contracts["contracts"].keys.peach do |method_name|

cmd = contracts["contracts"][method_name]["command"] + " --tags @" + "#{method_name}"
signature = "/#{method_name}"
contracts["contracts"][method_name]["input_params"].each_key do |param|
  signature += "/:taas_#{param}"
  cmd += " taas_#{param}=\#{params[:#{param}]}"
end

dir =   contracts["contracts"][method_name]["dir"]


block = Proc.new {
command_output = TaaS::CommandRunner.execute(dir,cmd)
data = "\"json_output\" : [#{TaaS::Server::Helper.parse_output(command_output)}]"
output_result = " \"passed\" : \"#{data.nil?}\", \"raw_output\": \"#{command_output}\""
"{ #{output_result}, #{data}}"
}

get signature, {}, &block

end



