require "rubygems"
require 'uri'
require 'net/http'
require "json"

module Client
  class TaaSClient

    attr_accessor :url, :timeout

    def initialize(url, timeout_in_seconds=1000)
      @url = url
      @timeout = timeout_in_seconds * 10000
    end

    def execute_contract(params={})
      uri = URI.parse(@url)
      http = Net::HTTP.new(uri.host, uri.port)

      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data(params)
      http.read_timeout = @timeout
      response = http.request(request)

      return result_output_hash_and_console_log(response.body)
    end

    def result_output_hash_and_console_log(response_body)
      console_log = response_body.scan(/<Taas command output start>(.*)<Taas command output ends>/m).flatten.first
      response_body.gsub!(/<Taas command output start>(.*)<Taas command output ends>/,"")
      response_hash = JSON.parse(response_body, {:symbolize_names => true})
      response_hash.delete(:console_log)
      return response_hash, console_log
    end
  end
end




