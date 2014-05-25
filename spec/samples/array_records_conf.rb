# coding: utf-8
require "configue"

class ArrayRecordsConf < Configue::Container
  config.source_file "#{File.dirname(__FILE__)}/array_records_conf.yml"
end
