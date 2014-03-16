# coding: utf-8

module ConfLogic
  class InnerHash < Hash
    def initialize(source_hash=nil)
      if source_hash
        deep_update(source_hash)

        sig = class << self; self; end
        source_hash.keys.each do |k|
          sig.__send__(:define_method, k, ->{ self[k] })
        end
      end
    end

    def fetch(key, *args); super(key.to_s, *args); end
    def delete(key); super(key.to_s); end
    def key?(key); super(key.to_s); end
    alias_method :has_key?, :key?

    alias_method :_get_value, :[]
    alias_method :_set_value, :[]=
    private :_get_value
    private :_set_value

    def [](key)
      value = _get_value(key.to_s)
      value = self.class.new(value) if value.is_a? Hash
      yield value if block_given?
      value
    end

    def []=(key, value)
      v = value
      v = self.class.new(v) if v.is_a? Hash
      _set_value(key.to_s, v)
    end

    protected
    def deep_update(other_hash, &b)
      other_hash.each do |k, v|
        if v.is_a?(Hash)
          v = self.key?(k) ? self[k].deep_update(v) : self.class.new(v)
        end
        self[k] = v
      end
      self
    end
  end
end
