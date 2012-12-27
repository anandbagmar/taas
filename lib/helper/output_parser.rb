require "json"
module TaaS
  class OutputParser
    def self.parse_taas_output(output)
      output.scan(/<TaaS Response Start>(.*)<TaaS Response Complete>/m).first.first rescue nil
    end

    def self.parse_server_output(response_body)
      return nil unless valid_server_response?(response_body)
      body = response_body.scan(/<Taas-Output>(.*)<\/TaaS-Output>/m).first.first
      response_json = response_body.scan(/<TaaS-Json>(.*)<\/TaaS-Json>/m).first.first
      response_hash = JSON.parse(response_json) rescue nil
      return nil if response_hash.nil?
      return response_hash,body
    end

    def self.valid_server_response?(response)
      pattern=/<TaaS-Server-Response><Taas-Output>(.*)<\/TaaS-Output><TaaS-Json>(.*)<\/TaaS-Json><\/TaaS-Server-Response>/
      !pattern.match(response).nil?
    end
  end
end