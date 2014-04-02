# coding: utf-8

require "configue/merger"

module Configue
  class SourceLoader
    def initialize(loader, sources, namespace=nil, base_namespace=nil)
      @loader = loader
      @sources = sources
      @namespace = namespace.to_s if namespace
      @basespace = base_namespace.to_s if base_namespace
    end

    def load
      @hash = {}
      @sources.each do |src|
        src.each {|k, v| __send__("load_#{k}", v) }
      end
      @hash
    end

    protected
    def load_dir(dir)
      Dir.glob("#{dir}/**/*.#{@loader.extention}") do |file|
        load_file(file)
      end
    end

    def load_file(file)
      source = @loader.load(file)
      if @namespace and source[@namespace]
        namespaced_hash(source)
      else
        Merger.merge(@hash, source)
      end
    end

    def namespaced_hash(hash)
      if @basespace and hash.key?(@basespace)
        Merger.merge(@hash, @basespace => hash[@basespace])
      end
      Merger.merge(@hash, @namespace => hash[@namespace])
      @hash
    end
  end
end
