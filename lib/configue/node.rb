# coding: utf-8
require 'configue/hash_node'
require 'configue/array_node'

module Configue
  class Node
    def initialize(object)
      raise TypeError unless object.respond_to?(:[])

      if object.is_a? self.class
        node_type = object.instance_variable_get(:@node_type)
      end

      if object.is_a? Hash or node_type == :hash
        setup_as_hash_node(object)
      elsif object.is_a? Array or node_type == :array
        setup_as_array_node(object)
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
      @container = hash.each.inject({}) do |h, (k, v)|
        sig.__send__(:define_method, k, ->{ self[k] })
        h[k.to_s] = node?(v) ? self.class.new(v) : v; h
      end
      sig.__send__(:include, HashNode)
      @node_type = :hash
    end

    def setup_as_array_node(array)
      sig = class << self; self; end
      @container = array
      @container = array.map {|x| self.class.new(x) } if array.is_a? Array
      sig.__send__(:include, ArrayNode)
      @node_type = :array
    end
  end
end
