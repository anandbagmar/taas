require "sinatra"

require "helper/contracts"
require "helper/command_executer"
require "helper/output_parser"

post "/contract" do
  response_json = '{"pass":"false","data":{}}'
  output = "Contract Name is either nil or not valid."
  if !params[:contract_name].nil? && !Contracts.is_empty? && Contracts.contains?(params[:contract_name])
    command = Contracts.get_contract(params[:contract_name]).command(params)
    dir = Contracts.get_contract(params[:contract_name]).value_of("dir")
    output = CommandExecuter.execute_command(command,dir)
    response_json = OutputParser.parse_taas_output(output)
  end
   "<TaaS-Server-Response><Taas-Output>#{output}</TaaS-Output><TaaS-Json>#{response_json}</TaaS-Json></TaaS-Server-Response>"
end