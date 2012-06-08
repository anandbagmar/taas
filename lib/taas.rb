require File.expand_path("#{File.dirname(__FILE__)}/client/taas_client")

module TaaS
  def self.start_server(contract_file)
    puts "Starting TaaS Server with Contract File #{contract_file}"
    server_path = "#{File.dirname(__FILE__)}/server/server.rb #{contract_file}"
    `ruby #{server_path}`
  end

  def self.client(url,timeout)
    Client::TaaSClient.new(url,timeout)
  end
end

