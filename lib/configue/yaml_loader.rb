# coding: utf-8
require "yaml"
require "erb"

module Configue
  class YamlLoader
    def extention
      "yml"
    end

    def load(path)
      buf = open(path).read
      return {} if buf.empty?
      YAML.load(ERB.new(buf).result)
    end
  end
end
