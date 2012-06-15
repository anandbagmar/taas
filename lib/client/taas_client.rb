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
    response_hash_json, command_output = strip_command_output(response.body)
    response_hash = JSON.parse(response.body)
    return response_hash, command_output
  end

  def strip_command_output(response)
    command_output = "#{response.scan(/command_output\"\:(.*)\,\"json/m)}"
    response.gsub!(/command_output\"\:(.*)\,\"json/,'json')
    return response, command_output
  end
end
end




