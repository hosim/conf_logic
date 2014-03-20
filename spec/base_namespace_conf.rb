# coding: utf-8
require "configue"

class BaseNamespaceConf < Configue::Container
  config.source_dir "#{File.dirname(__FILE__)}/namespace"
  config.base_namespace :base
  config.namespace :test
end
