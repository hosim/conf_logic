# coding: utf-8
require "configue"

class SingleSourceConf < Configue::Container
  config.source_file "#{File.dirname(__FILE__)}/config/admin.yml"
  config.load!
end
