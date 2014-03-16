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

      def path?(path, delimiter=".")
        keys = path.to_s.split(delimiter)
        keys.each.inject(@setting.hash) do |h, key|
          return false unless h.has_key?(key)
          h[key]
        end
        return true
      end
      alias_method :has_path?, :path?
    end
  end
end
