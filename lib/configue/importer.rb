# coding: utf-8

module Configue
  module Importer
    def self.included(clazz)
      clazz.extend(ClassMethod)
    end
  end

  module ClassMethod
    # Imports a configuration as one of attributes.
    #
    # The following keys are available:
    #
    # +as+:: (required) a name of an attribute for the configuration.
    # +from_dir+:: a path of a directory that the configuration file is in.
    # +from_file+:: a path of the configuration file.
    # +namespace+:: a name of namespace.
    # +base_namespace+:: a name of base namespace.
    #
    def import_config(args)
      raise ArgumentError unless args.respond_to?(:[])
      var = args.delete(:as) || 'config'

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
