# coding: utf-8

require "configue/criteria"

module Configue
  class Container < Node

    def query(key=nil)
      q = Criteria.new(@hash)
      q = key.split('.').each.inject(q) {|c, k| c[k] } if key
      q
    end

    class << self
      def config
        @config_access_name = "config"
        @setting ||= Setting.new(self)
      end

      def config_setting
        @config_access_name = "config_setting"
        @setting ||= Setting.new(self)
      end

      private
      def method_missing(name, *args, &block)
        # makes @instance in this line.
        @setting.load!

        if @instance.key?(name)
          @instance[name]
        else
          @instance.__send__(name, *args, &block)
        end
      end
    end
  end
end
