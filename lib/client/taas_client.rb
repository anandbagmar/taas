require 'uri'
require 'net/http'
require "json"


class TaaSClient

  attr_accessor :url, :timeout

  def initialize(url, timeout_in_seconds=1000)
    @url = url
    @timeout = timeout_in_seconds * 10000
  end

  def execute_contract(contract_name, params={})
    uri = URI.parse(@url)
    http = Net::HTTP.new(uri.host, uri.port)

    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(params)
    http.read_timeout = @timeout
    response = http.request(request)

    JSON.parse(strip_body_tags(parse_output(response.body)))
  end

  private

  def strip_body_tags(string)
    string.gsub(/<body>/, "").gsub(/<\/body>/, "")
  end

  def parse_output(body)
    "#{body.match(/<body>(.*)<\/body>/m)}"
  end
end




