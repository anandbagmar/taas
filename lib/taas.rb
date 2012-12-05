require "server"
require "taas_client"
require "helper/command_executer"
require "helper/contracts"

module TaaS
    def self.start_server(contract_file)
      CommandExecuter.execute_command(File.dirname(__FILE__),"ruby server.rb #{contract_file}")
    end

    def self.client(url, timeout)
      TaaSClient.new(url, timeout)
    end
end
