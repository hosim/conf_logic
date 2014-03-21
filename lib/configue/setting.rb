# coding: utf-8

require "configue/yaml_loader"

module Configue
  class Setting
    def initialize(owner_class)
      @owner_class = owner_class
      @loader = YamlLoader.new
    end

    def base_namespace(key=nil)
      @base_namespace = key if key
      @base_namespace
    end

    def base_namespace=(key)
      base_namespace(key)
    end

    def namespace(key=nil)
      @namespace = key if key
      @namespace
    end

    def namespace=(key)
      namespace(key)
    end

    def source_dir(*dirs)
      @source_dirs ||= []
      @source_dirs += dirs unless dirs.empty?
      @source_dirs
    end

    def source_dir=(dir)
      if dir.is_a?(Array)
        source_dir(*dir)
      else
        source_dir(dir)
      end
    end

    def load!
      instance = @owner_class.instance_variable_get(:@instance)
      return instance if instance

      instance = @owner_class.new(load_sources)
      @owner_class.instance_variable_set(:@instance, instance)

      sig = class << @owner_class; self; end
      instance.keys.each do |k|
        next unless k.to_s =~ /\A\w+\z/
        sig.__send__(:define_method, k, -> { instance[k] })
      end
    end

    private
    def load_sources
      hash = load_each_source

      space = namespace.to_s
      unless space.empty?
        base = base_namespace.to_s
        result = InnerHash.new
        result.deep_merge!(hash[base]) if base_namespace
        result.deep_merge!(hash[space]) if hash[space]
        hash = result
      end
      hash
    end

    def load_each_source
      @source_dirs.each.inject(InnerHash.new) do |root, dir|
        Dir.glob("#{dir}/**/*.#{@loader.extention}") do |path|
          source = @loader.load(path)
          if namespace and source[namespace.to_s]
            namespaced_hash(root, source)
          else
            root.deep_merge!(source)
          end
        end
        root
      end
    end

    def namespaced_hash(root, hash)
      base = base_namespace.to_s
      space = namespace.to_s

      root.deep_merge!(base => hash[base]) if ! base.empty? and hash[base]
      root.deep_merge!(space => hash[space])
      root
    end

    def method_missing(name, *args, &block)
      access_name = @owner_class.instance_variable_get(:@config_access_name)
      return super unless access_name

      instance = self.load!

      nm = name.to_s
      if instance[access_name] and instance[access_name].key?(nm)
        instance[access_name][nm]
      elsif [:keys, :key?, :has_key?].index(name)
        instance[access_name].__send__(name, *args, &block)
      else
        super
      end
    end
  end
end
