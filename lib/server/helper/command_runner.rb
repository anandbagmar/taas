module TaaS
  module CommandRunner
    def execute(dir, command)
      return nil if command.nil? || dir.nil?
      Dir.chdir(dir)
      puts "Running command -> #{command}"
      command = `#{command}`
    end

    def execute_contract(dir,command, input_hash)
      full_command = "#{command}#{create_params_string(input_hash)}"
      execute(dir, full_command)
    end

    def create_params_string(input_hash)
      input_string = " "
      input_hash.each_pair do |key, value|
        input_string+="taas_#{key}=#{value} "
      end
      input_string
    end
  end
end

