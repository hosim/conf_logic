# coding: utf-8

module Configue
  class Criteria
    def initialize(hash)
      @hash = hash
      @path = []
    end

    def [](key)
      @path << key.to_s
      self
    end

    def retrieve
      @path.each.inject(@hash) do |h, key|
        return nil unless h.is_a?(Hash) and h.has_key?(key)
        h[key]
      end
    end

    def exist?
      @path.each.inject(@hash) do |h, key|
        return false unless h.is_a?(Hash) and h.has_key?(key)
        h[key]
      end
      true
    end
  end
end
