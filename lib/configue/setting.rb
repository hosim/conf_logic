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

    def source_dir(dir=nil)
      @source_dirs ||= []
      @source_dirs << dir if dir
      @source_dirs
    end

    def source_dir=(dir)
      source_dir(dir)
    end

    def load_source
      space = namespace

      @source_dirs.each.inject(InnerHash.new) do |root, dir|
        Dir.glob("#{dir}/**/*.yml") do |path|
          source = @loader.load(path)
          h = space ? source[space.to_s] : source
          root.deep_merge!(h) if h
        end
        root
      end
    end
  end
end
