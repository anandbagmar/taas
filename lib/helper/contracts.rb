module TaaS
  class Contracts

    @@contract_hash = {}

    def self.load(absolute_path)
      raise "File path cant be nil or empty" if absolute_path.empty?
      @@contract_hash = YAML.load_file(absolute_path) rescue {}
    end

    def self.is_empty?
      @@contract_hash.eql?({})
    end

    def self.contains?(contract_name)
      @@contract_hash["contracts"].keys.include?(contract_name)
    end

    def self.get_execution_attribute(attribute, contract_name)
      return nil if @@contract_hash.nil? || @@contract_hash.eql?({})
      @@contract_hash["contracts"][contract_name.to_s][attribute]
    end
  end
end