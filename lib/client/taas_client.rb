module TaaS
  @taas = nil

  class TaaSClient

    attr_accessor :url, :timeout

    def initialize(url, timeout_in_seconds)
      @url = url
      @timeout = timeout_in_seconds * 1000
    end

    private

    def url_for(contract_name, input_params)
      contract_url = @url + "/#{contract_name}"
      input_params.values.each {|input_param_value| contract_url += "/#{input_param_value}" }
      contract_url
    end

    def execute_contract(contract_name, input_params)
      uri = URI.parse(url_for(contract_name,input_params))
      http_end_point = Net:HTTP.new(uri.host, url.port)

      #configure the timeout setting for the http endpoint
      http_end_point.read_timeout = @timeout

      http_response = http_end_point.request(Net::HTTP::Get.new(uri.request_uri))

      puts "http_response for contract: #{contract_name} with parameters:\n\t#{input_params}\n#{http_response.inspect}"
    end
  end

  def configure (url,timeout_in_seconds)
    @taas.nil? ? TaaSClient.new(url, timeout_in_seconds) : @taas
  end

  def execute(contract_name,input_params={})
    if (@taas.nil?)
      raise 'TaaS NOT configured. Please configure TaaS first by calling the following method:\n\tTaaS.configure(url,timeout)'
    end
    execute_contract(contract_name,input_params)
  end

  def reset
    @taas = nil
  end
end