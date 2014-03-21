# coding: utf-8

class ConfigConf < Configue::Container
  config.source_dir "#{File.dirname(__FILE__)}/config"
  config.load!
end
