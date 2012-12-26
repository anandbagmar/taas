require "sinatra"

require "helper/contracts"
require "helper/command_executer"
require "helper/output_parser"
require "helper/contract"
require "helper/parameter_factory"

include TaaS
log = Logger.new(STDOUT)

Contracts.load(ARGV[0])
log.info("Contract file #{ARGV[0]} is Loaded")

post "/contract" do
  log.info("Request for execution of contract #{params["contract_name"]} with parameters #{params.inspect}")
  response_json = '{"pass":"false","data":{}}'
  output = "Contract Name is either nil or not valid."
  if !params["contract_name"].nil? && !Contracts.is_empty? && Contracts.contains?(params["contract_name"])
    log.info("Fetching the contract Command and Directory")
    command = Contracts.get_contract(params["contract_name"]).command(params)
    dir = Contracts.get_contract(params["contract_name"]).value_of("dir")
    log.info("Executing command #{command} in directory #{dir}")
    output = CommandExecuter.execute_command(dir,command)
    response_json = OutputParser.parse_taas_output(output)
    log.info("Response is generated")
  end
   "<TaaS-Server-Response><Taas-Output>#{output}</TaaS-Output><TaaS-Json>#{response_json}</TaaS-Json></TaaS-Server-Response>"
end