module TaaS
  class Contract

    def initialize(hash)
      @hash = hash
    end

    def value_of(key)
      @hash[key]
    end

    def has_property?(key)
      @hash.has_key?(key)
    end

    def command(params)
      command = @hash["command"]
      parameter_string = ParameterFactory.generate_parameter_string(@hash["input_param_format"],params)
      command.scan(/<taas_params>/).empty? ? command+parameter_string : command.gsub("<taas_params>",parameter_string)
    end
  end
end