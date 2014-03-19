# coding: utf-8

require "forwardable"

module Configue
  class Container
    extend Forwardable

    def_delegators :@node, :keys, :key?, :has_key?, :[]

    def initialize(hash)
      @node = hash
    end

    def walk
      Criteria.new(@node)
    end

    class << self
      def config_setting
        @setting ||= Setting.new(self)
      end

      private
      def method_missing(name, *args, &block)
        @instance ||= new(@setting.load_source)
        if @instance.key?(name)
          @instance[name]
        else
          @instance.__send__(name, *args, &block)
        end
      end
    end
  end
end
