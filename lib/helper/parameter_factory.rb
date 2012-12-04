module TaaS
  class ParameterFactory
    def self.generate_parameter_string(template,params_hash)
      parameter_string = ""
      template = "key=value" if template.nil?
      params_hash.each do |key,value|

         parameter_string += " #{template.gsub("key",key.to_s).gsub("value",value.to_s)}"
      end
      parameter_string
    end
  end
end