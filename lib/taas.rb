require "server"
require "taas_client"

module Taas
  class << self
    def self.start_server(contract_file)
      Contracts.load(contract_file)
      CommandExecuter.execute_command("ruby server.rb", File.dirname(__FILE__))
    end

    def self.client(url, timeout)
      TaaSClient.new(url, timeout)
    end
  end
end
