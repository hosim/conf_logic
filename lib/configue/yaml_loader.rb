# coding: utf-8
require "yaml"

module Configue
  class YamlLoader
    def extention
      "yml"
    end

    def load(path)
      YAML.load_file(path)
    end
  end
end
