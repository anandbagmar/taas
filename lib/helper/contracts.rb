require 'pry'
module TaaS
  class Contracts

    @@contract_hash = {}

    def self.load(absolute_path)
      raise "File path cant be nil or empty" if (absolute_path.nil? || absolute_path.empty?)
      @@contract_hash = YAML.load_file(absolute_path)["contracts"] rescue {}
    end

    def self.is_empty?
      @@contract_hash.eql?({}) || @@contract_hash.nil?
    end

    def self.contains?(contract_name)
      @@contract_hash.keys.include?(contract_name)
    end

    def self.get_contract(contract_name)
      return nil unless contains?(contract_name)
      contract = Contract.new @@contract_hash[contract_name]
      contract
    end

    def self.get_execution_attribute(attribute, contract_name)
      return nil if @@contract_hash.nil? || @@contract_hash.eql?({})
      @@contract_hash["contracts"][contract_name.to_s][attribute]
    end

    def self.get_all_contracts
      return @@contract_hash
    end
  end
end