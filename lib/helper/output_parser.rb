module TaaS
  class OutputParser
    def self.parse_taas_output(output)
      output.scan(/<TaaS Response Start>(.*)<TaaS Response Complete>/m)
    end

    def self.parse_server_output(response_body)
      return response_body, response_body
    end
  end
end