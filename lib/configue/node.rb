# coding: utf-8

module Configue
  class Node
    def initialize(hash)
      raise TypeError unless hash.respond_to?(:[])

      sig = class << self; self; end
      @hash = hash.each.inject({}) do |h, (k, v)|
        sig.__send__(:define_method, k, ->{ self[k] })
        h[k.to_s] = v; h
      end
      self
    end

    def [](key)
      k = key.to_s
      v = @hash[k]
      @hash[k] = self.class.new(v) if v.is_a?(Hash)
      @hash[k]
    end

    def fetch(key)
      k = key.to_s
      v = @hash[key]
      @hash[k] = self.class.new(v) if v.is_a?(Hash)
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

    [ :keys,
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
