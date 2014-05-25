# coding: utf-8

module Configue
  module HashNode
    def [](key)
      k = key.to_s
      v = @hash[k]
      @hash[k] = self.class.new(v) if node?(v)
      @hash[k]
    end

    def fetch(key)
      k = key.to_s
      v = @hash[key]
      @hash[k] = self.class.new(v) if node?(v)
      @hash.fetch(k)
    end

    def key?(key)
      k = key.to_s
      @hash.key?(k)
    end
    alias_method :has_key?, :key?
    alias_method :include?, :key?
    alias_method :member?,  :key?

    def assoc(key)
      k = key.to_s
      @hash.assoc(k)
    end

    def to_hash
      @hash.dup
    end

    def values_at(*keys)
      ks = keys.map {|k| k.to_s }
      @hash.values_at(*ks)
    end

    [ :all?,
      :any?,
      :collect,
      :count,
      :cycle,
      :keys,
      :to_s,
      :each,
      :each_pair,
      :each_key,
      :empty?,
      :value?,
      :size,
      :length,
      :merge,
      :rassoc,
      :reject,
      :select,
      :sort,
      :to_a,
      :values,
    ].each do |m|
      define_method(m, ->(*args, &block) {
                      @hash.__send__(m, *args, &block)
                    })
    end
  end
end
