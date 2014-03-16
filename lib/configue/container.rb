# coding: utf-8

module Configue
  class Container
    class << self
      def config_setting
        @setting ||= Setting.new(self)
      end

      def [](*args)
        args.each.inject(@setting.hash) do |h, key|
          h[key.to_s] if h
        end
      end

      def key?(key); @setting.hash.key?(key.to_s); end
      alias_method :has_key?, :key?
    end
  end
end
