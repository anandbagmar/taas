module TaaS
  def self.start_server
    puts "Starting TaaS Server"
    server_path = "#{File.dirname(__FILE__)}/server/server.rb"
    eval("ruby server_path")
  end
end
