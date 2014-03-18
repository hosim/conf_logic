# coding: utf-8
require "yaml"
require "forwardable"

module Configue
  class Setting
    attr_reader :hash

    def initialize(owner_class)
      @owner_class = owner_class
    end

    def source_dir(dir)
      @hash ||= InnerHash.new

      Dir.glob("#{dir}/**/*.yml") do |filenm|
        h = YAML.load_file(filenm)
        @hash.deep_merge!(h)
      end

      methods = [:[], :key?, :has_key?] + @hash.keys

      @owner_class.extend SingleForwardable
      methods.each do |m|
        @owner_class.def_delegator "@setting.hash", m
      end

      @hash
    end
  end
end
