# coding: utf-8

module Configue
  module Importer
    def self.included(clazz)
      clazz.extend(ClassMethod)
    end
  end

  module ClassMethod
    def import_config(args)
      raise ArgumentError unless args.respond_to?(:[])
      var = args.delete(:as)
      raise if var.nil?

      dirs = args.delete(:from_dir)
      files = args.delete(:from_file)
      args[:source_dir] = dirs if dirs
      args[:source_file] = files if files

      config = Class.new(Container)
      args.each {|k, v| config.config.__send__(k, *Array(v)) }

      define_method(var, -> { config })
      nil
    end
  end
end
