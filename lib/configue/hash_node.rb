# coding: utf-8

module Configue
  module HashNode
    def [](key)
      k = key.to_s
      v = @container[k]
      @container[k] = self.class.new(v) if node?(v)
      @container[k]
    end

    def fetch(key)
      k = key.to_s
      v = @container[key]
      @container[k] = self.class.new(v) if node?(v)
      @container.fetch(k)
    end

    def key?(key)
      k = key.to_s
      @container.key?(k)
    end
    alias_method :has_key?, :key?
    alias_method :include?, :key?
    alias_method :member?,  :key?

    def assoc(key)
      k = key.to_s
      @container.assoc(k)
    end

    def to_hash
      @container.dup
    end

    def values_at(*keys)
      ks = keys.map {|k| k.to_s }
      @container.values_at(*ks)
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
                      @container.__send__(m, *args, &block)
                    })
    end
  end
end
