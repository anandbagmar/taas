namespace :taas do
  desc 'Start the TaaS server'
  task :start, :file_name do |t, args|
    filepath = (args[:file_name]) || ("#{File.dirname(__FILE__)}/../server/contracts.yaml")
    server_path = "#{File.dirname(__FILE__)}/../server/server.rb " + filepath
    eval("ruby server_path")
  end
end
