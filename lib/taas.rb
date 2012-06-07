require "lib/client/taas_client"

module TaaS
  def self.start_server
    puts "Starting TaaS Server"
    server_path = "#{File.dirname(__FILE__)}/server/server.rb"
    eval("ruby server_path")
  end

  def self.client(url,timeout)
    Client::TaaSClient.new(url,timeout)
  end
end

