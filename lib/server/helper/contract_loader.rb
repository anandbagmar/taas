module TaaS
  module ContractLoader
    def load_file(file_name)
      YAML.load_file("#{Dir.pwd}/#{file_name}") rescue nil
    end
  end
end
