# coding: utf-8

module ConfLogic
  class Container
    class << self
      def conf_setting
        @setting ||= Setting.new(self)
      end

      def [](*args)
        key = args[0].to_s
        @setting.hash[key]
      end

      def key?(key); @setting.hash.key?(key.to_s); end
      alias_method :has_key?, :key?
    end
  end
end
