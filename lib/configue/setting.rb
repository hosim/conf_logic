# coding: utf-8

require "configue/merger"
require "configue/source_loader"
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

    # Specifies files that you want to load into your class.
    #
    # You can call this method many times.
    #
    # ====Arguments
    # - +files+: files that you want to load into your class.
    #
    def source_file(*files)
      @sources ||= []
      @sources += files.map {|f| {file: f}} unless files.empty?
      @sources
    end

    def source_file=(file)
      if file.is_a?(Array)
        source_file(*file)
      else
        source_file(file)
      end
    end

    def load!
      @owner.instance ? @owner.instance : @owner.new_container(load_sources)
    end

    private
    def load_sources
      loader = SourceLoader.new(@loader, @sources, @namespace, @base_namespace)
      hash = loader.load
      hash = namespaced_hash(hash) if namespace
      hash
    end

    def namespaced_hash(hash)
      space = namespace.to_s
      base = base_namespace.to_s
      result = {}
      result = Merger.merge(result, hash[base]) if base_namespace
      result = Merger.merge(result, hash[space]) if hash.key?(space)
      result
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
