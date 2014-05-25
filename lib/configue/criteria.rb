# coding: utf-8

module Configue
  class Criteria
    def initialize(container, *path)
      @container = container
      @path = path
    end

    def [](key)
      self.class.new(@container, *@path, key.to_s)
    end

    def retrieve
      @path.each.inject(@container) do |h, key|
        return nil unless h.respond_to?(:has_key?) and h.has_key?(key)
        h[key]
      end
    end

    def exist?
      @path.each.inject(@container) do |h, key|
        return false unless h.respond_to?(:has_key?) and h.has_key?(key)
        h[key]
      end
      true
    end
  end
end
