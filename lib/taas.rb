require "server"
require "taas_client"
require "helper/command_executer"
require "helper/contracts"

module TaaS
    def self.start_server(contract_file)
      Contracts.load(contract_file)
      CommandExecuter.execute_contract(File.dirname(__FILE__),"ruby server.rb")
    end

    def self.client(url, timeout)
      TaaSClient.new(url, timeout)
    end
end
