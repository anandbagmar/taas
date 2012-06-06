namespace :taas do
  desc 'Start the TaaS server'
  task :start, :file_name do |t, args|
    server_path = "#{File.dirname(__FILE__)}/../server.rb"
    eval("ruby server_path #{args[:args1]}")
  end
end
