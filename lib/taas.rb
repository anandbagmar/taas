Dir.glob('**/*.rb').each { |r|
  puts "Importing: #{r}"
  require r
}
#require "taas/version"

#import "#{File.dirname(__FILE__)}/**/*.rake"

module TaaS
  # Your code goes here...
  def start_server
    puts "TaaS.start_server"
  end
end
