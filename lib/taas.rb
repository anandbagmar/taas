Dir.glob('**/*.rb').each { |r|
  puts "\t.. importing: #{r}"
  require r
}

module TaaS
  # Your code goes here...
  def self.start_server
    puts "TaaS.start_server"
    server_path = "#{File.dirname(__FILE__)}/server/server.rb"
    eval("ruby server_path")
  end
end
