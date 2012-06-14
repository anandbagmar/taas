module TaaS
  module Server
    module Helper

      def parse_output(output)
        json_output = extract_output(output)
        strip_brackets(json_output)
      end

      def extract_output(command_output)
        "#{command_output.scan(/<TaaS Response Start>(.*)<TaaS Response Completed>/m)}"
      end

      def strip_brackets(string)
        string.gsub(/\{/, "").gsub(/\}/, "")
      end

    end
  end
end
