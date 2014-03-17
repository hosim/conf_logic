# coding: utf-8

module Configue
  class Container
    class << self
      def config_setting
        @setting ||= Setting.new(self)
      end

      def [](key)
        @setting.hash[key]
      end

      def key?(key); @setting.hash.key?(key); end
      alias_method :has_key?, :key?

      def query
        Criteria.new(@setting.hash)
      end
    end
  end
end
