# coding: utf-8

class TripleYamlConf < Configue::Container
  config.source_file "#{File.dirname(__FILE__)}/triple_yaml/base.yml"
  config.source_file "#{File.dirname(__FILE__)}/triple_yaml/production.yml"
  config.source_file "#{File.dirname(__FILE__)}/triple_yaml/development.yml"

  config.base_namespace :base
  config.namespace :development
end
