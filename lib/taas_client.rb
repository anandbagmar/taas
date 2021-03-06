require "rubygems"
require 'uri'
require 'net/http'
require "json"
require File.join("helper","output_parser")

module TaaS
  class TaaSClient

    attr_accessor :url, :timeout

    def initialize(url, timeout_in_seconds=1000)
      @url = url
      p "url: " + url
      @timeout = timeout_in_seconds * 10000
    end

    def execute_contract(params={})
      response_body = request_taas_server(params)

      p "execute_contract: params: " + params.inspect
      raise "TaaS Request is false" unless OutputParser.valid_server_response?(response_body)

      OutputParser.parse_server_output(response_body)
    end



    def request_taas_server(params)
      uri = URI.parse(@url)
      http = Net::HTTP.new(uri.host, uri.port)

      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data(params)
      http.read_timeout = @timeout
      http.request(request).body
    end
  end
end



