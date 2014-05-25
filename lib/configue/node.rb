# coding: utf-8
require 'configue/hash_node'
require 'configue/array_node'

module Configue
  class Node
    def initialize(hash)
      raise TypeError unless hash.respond_to?(:[])

      node_type = hash.instance_variable_get(:@node_type) if hash.is_a? self.class
      if hash.is_a? Hash or node_type == :hash
        setup_as_hash_node(hash)
      elsif hash.is_a? Array or node_type == :array
        setup_as_array_node(hash)
      end
      self
    end

    private
    def node?(object, counter=0)
      return true if object.is_a? Hash
      return false if counter >= 3
      return object.any? {|n| node?(n, counter + 1) } if object.is_a? Array
      return false
    end

    def setup_as_hash_node(hash)
      sig = class << self; self; end
      @hash = hash.each.inject({}) do |h, (k, v)|
        sig.__send__(:define_method, k, ->{ self[k] })
        h[k.to_s] = node?(v) ? self.class.new(v) : v; h
      end
      sig.__send__(:include, HashNode)
      @node_type = :hash
    end

    def setup_as_array_node(array)
      sig = class << self; self; end
      @hash = array
      @hash = array.map {|x| self.class.new(x) } if array.is_a? Array
      sig.__send__(:include, ArrayNode)
      @node_type = :array
    end
  end
end
