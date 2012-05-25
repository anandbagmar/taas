module Server
  module Helper
    def parse_output(output)
      strip_output_tag("#{output.match(/<WS Response Start>(.*)<WS Response Completed>/m)}")
    end

    def strip_output_tag(string)
      string.gsub(/<WS Response Start>/,"").gsub(/<WS Response Completed>/,"").gsub(/\{/,"").gsub(/\}/,"")
    end
  end
end