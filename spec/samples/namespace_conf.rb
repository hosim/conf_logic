# coding: utf-8
require "configue"

class NamespaceConf < Configue::Container
  config.source_dir "#{File.dirname(__FILE__)}/namespace"
  config.namespace :dev
end
