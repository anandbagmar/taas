namespace :taas do
  task :start do
    server_path = "#{File.dirname(__FILE__)}/../server.rb"
    eval("ruby server_path")
  end
end
