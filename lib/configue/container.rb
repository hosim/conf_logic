# coding: utf-8

module Configue
  class Container
    class << self
      def config_setting
        @setting ||= Setting.new(self)
      end

      def walk
        Criteria.new(@setting.hash)
      end
    end
  end
end
