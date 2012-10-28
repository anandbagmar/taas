require "rubygems"
require 'uri'
require 'net/http'
require "json"
require "helper/output_parser"

module TaaS
  class TaaSClient

    attr_accessor :url, :timeout

    def initialize(url, timeout_in_seconds=1000)
      @url = url
      @timeout = timeout_in_seconds * 10000
    end

    def execute_contract(params={})
      response_body = request_taas_server(params)

      raise "TaaS Request is false" unless valid_server_response?(response_body)

      OutputParser.parse_server_output(response_body)
    end

    def valid_server_response?(response)
      pattern=/<TaaS-Server-Response><Taas-Output>(.*)<\/TaaS-Output><TaaS-Json>(.*)<\/TaaS-Json><\/TaaS-Server-Response>/
      !pattern.match(response).nil?
    end

    def request_taas_server(params)
      uri = URI.parse(@url)
      http = Net::HTTP.new(uri.host, uri.port)

      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data(params)
      http.read_timeout = @timeout
      http.request(request)
    end
  end
end



