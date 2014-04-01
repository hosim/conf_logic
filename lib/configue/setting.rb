# coding: utf-8

require "configue/merger"
require "configue/yaml_loader"

module Configue
  class Setting
    def initialize(owner_class)
      @owner = owner_class
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
      @sources ||= []
      @sources += dirs.map {|d| {dir: d}} unless dirs.empty?
      @sources
    end

    def source_dir=(dir)
      if dir.is_a?(Array)
        source_dir(*dir)
      else
        source_dir(dir)
      end
    end

    def source_file(*files)
      @sources ||= []
      @sources += files.map {|f| {file: f}} unless files.empty?
      @sources
    end

    def load!
      @owner.instance ? @owner.instance : @owner.new_container(load_sources)
    end

    private
    def load_sources
      hash = load_each_source

      space = namespace.to_s
      unless space.empty?
        base = base_namespace.to_s
        result = {}
        Merger.merge(result, hash[base]) if base_namespace
        Merger.merge(result, hash[space]) if hash.key?(space)
        hash = result
      end
      hash
    end

    def load_each_source
      @sources.each.inject({}) do |root, src|
        if src.key?(:dir)
          Dir.glob("#{src[:dir]}/**/*.#{@loader.extention}") do |path|
            load_source_file(root, path)
          end
        elsif src.key?(:file)
          load_source_file(root, src[:file])
        end
        root
      end
    end

    def load_source_file(root, path)
      source = @loader.load(path)
      if namespace and source[namespace.to_s]
        namespaced_hash(root, source)
      else
        Merger.merge(root, source)
      end
    end

    def namespaced_hash(root, hash)
      base = base_namespace.to_s
      space = namespace.to_s

      if ! base.empty? and hash.key?(base)
        Merger.merge(root, base => hash[base])
      end
      Merger.merge(root, space => hash[space])
      root
    end

    def method_missing(name, *args, &block)
      access_name = @owner.config_method_name
      return super unless access_name

      instance = self.load!
      if instance[access_name]
        instance[access_name].__send__(name, *args, &block)
      else
        super
      end
    end
  end
end
