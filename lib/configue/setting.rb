# coding: utf-8
require "yaml"

module Configue
  class Setting
    def initialize(owner_class)
      @owner_class = owner_class
    end

    def source_dir(dir)
      @hash ||= InnerHash.new
      Dir.glob("#{dir}/**/*.yml") do |filenm|
        h = YAML.load_file(filenm)
        @hash.__send__(:deep_update, h)

        sig = class << @owner_class; self; end
        h.keys.each do |k|
          sig.__send__(:define_method, k, ->{ self[k] })
        end
      end
      @hash
    end

    attr_reader :hash
  end
end
