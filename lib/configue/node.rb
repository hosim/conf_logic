# coding: utf-8
require 'configue/hash_node'
require 'configue/array_node'

module Configue
  class Node
    def initialize(hash)
      raise TypeError unless hash.respond_to?(:[])

      node_type = hash.instance_variable_get(:@node_type) if hash.is_a? self.class
      sig = class << self; self; end
      if hash.is_a? Hash or node_type == :hash
        @hash = hash.each.inject({}) do |h, (k, v)|
          sig.__send__(:define_method, k, ->{ self[k] })
          h[k.to_s] = v; h
        end
        sig.__send__(:include, HashNode)
        @node_type = :hash
      elsif hash.is_a? Array or node_type == :array
        @hash = hash
        sig.__send__(:include, ArrayNode)
        @node_type = :array
      end
      self
    end

    private
    def node?(object)
      return true if object.is_a? Hash
      if object.is_a? Array
        return object.any? {|n| node?(n) }
      end
      return false
    end
  end
end
