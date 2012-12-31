require "sinatra"

require "helper/contracts"
require "helper/command_executer"
require "helper/output_parser"
require "helper/contract"
require "helper/parameter_factory"

include TaaS

Contracts.load(ARGV[0])

post "/contract" do
  response_json = '{"pass":"false","data":{}}'
  output = "Contract Name is either nil or not valid."
  if !params["contract_name"].nil? && !Contracts.is_empty? && Contracts.contains?(params["contract_name"])
    command = Contracts.get_contract(params["contract_name"]).command(params)
    dir = Contracts.get_contract(params["contract_name"]).value_of("dir")
    output = CommandExecuter.execute_command(dir,command)
    response_json = OutputParser.parse_taas_output(output)
  end
   "<TaaS-Server-Response><Taas-Output>#{output}</TaaS-Output><TaaS-Json>#{response_json}</TaaS-Json></TaaS-Server-Response>"
end


get "/" do
  table_header ="<table width=\"600\" border=\"1\"><tr><th>Contract Name</th><th>Contract parameters</th></tr>"
  table_footer="</table>"
  table_body =""
  Contracts.get_all_contracts.each_pair do |key,value|
    inner_table_body=""
    inner_table_header ="<table width=\"400\" border=\"1\"><tr><th>KEY</th><th>VALUE</th></tr>"
    inner_table_footer="</table>"
    value.each_pair do |key1,value1|
      inner_table_body = inner_table_body + "<tr><td>#{key1}</td><td>#{value1}</td></tr>"
    end
    inner_table = inner_table_header+inner_table_body+inner_table_footer
    table_body = table_body + "<tr><td>#{key}</td><td>#{inner_table}</td></tr>"
   end
   table_header+table_body+table_footer
end