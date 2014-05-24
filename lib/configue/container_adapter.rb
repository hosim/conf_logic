# coding: utf-8

module Configue
  class ContainerAdapter
    def initialize(container_class)
      @class = container_class
    end

    def new_container(hash)
      self.instance = @class.new(hash)
    end

    def instance
      @class.instance_variable_get(:@instance)
    end

    def instance=(arg)
      raise TypeError unless arg.respond_to?(:[])

      @class.instance_variable_set(:@instance, arg)
      if arg.respond_to?(:keys)
        sig = class << @class; self; end
        arg.keys.each do |k|
          next unless k.to_s =~ /\A\w[\w0-9]*\z/
          sig.__send__(:define_method, k, -> { arg[k] })
        end
      end
      arg
    end

    def config_method_name
      @class.instance_variable_get(:@config_access_name)
    end
  end
end
