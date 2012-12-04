module TaaS
  module CommandRunner
    def execute(dir, command)
      return nil if command.nil? || dir.nil?
      Dir.chdir(dir)
      puts "Running command -> #{command}"
      command = `#{command}`
    end

    def execute_contract(dir,command, input_hash, expected_input_param_format)
      full_command = "#{command} #{create_params_string(input_hash, expected_input_param_format)}"
      execute(dir, full_command)
    end

    def create_params_string(input_hash, expected_input_param_format)
      input_string = " "
      input_hash.each_pair do |key, value|
        input_string+= expected_input_param_format.gsub("key"," taas_"+key.to_s).gsub("value",value.to_s)
      end
      input_string
    end
  end
end

