require "bundler/gem_tasks"
Dir.glob('**/*.rake').each { |r|
  puts "Importing: #{r}"
  import r
}

require "#{File.dirname(__FILE__)}/lib/taas.rb"
require "#{File.dirname(__FILE__)}/test/client/taas_client_test.rb"

namespace :taas do
  desc 'Start the TaaS Server'
  task :start_server do
    TaaS.start_server
  end

  desc 'Start the TaaS Server'
  task :start_test_server do
    TaaSClientTest.start_test_server
  end

  desc 'Start the TaaS Server'
  task :run_test  do
    test_file_path = "#{File.dirname(__FILE__)}/test/client/taas_client_test.rb"
    eval("ruby test_file_path")
  end
  end


