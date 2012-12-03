module TaaS
  class Contract

    def initialize(hash)
      @hash = hash
    end

    def value_of(key)
      @hash[key]
    end

    def has_property?(key)
      @hash.has_key?(key)
    end
  end
end