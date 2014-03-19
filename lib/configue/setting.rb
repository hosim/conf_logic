# coding: utf-8
require "configue/yaml_loader"

module Configue
  class Setting
    def initialize(owner_class)
      @owner_class = owner_class
      @loader = YamlLoader.new
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

    def load_source
      space = namespace.to_s

      @source_dirs.each.inject(InnerHash.new) do |root, dir|
        Dir.glob("#{dir}/**/*.#{@loader.extention}") do |path|
          source = @loader.load(path)
          h = space.empty? ? source : source[space]
          root.deep_merge!(h) if h
        end
        root
      end
    end
  end
end
