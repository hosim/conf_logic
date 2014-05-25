# coding: utf-8

module Configue
  module Merger
    MERGER = ->(key, h1, h2) {
      if h1.is_a?(Hash) and h2.is_a?(Hash)
        h1.merge(h2, &MERGER)
      else
        h2
      end
    }
    private_constant :MERGER

    def merge(hash1, hash2)
      return hash2 unless hash1
      return hash1 unless hash2

      if hash1.is_a?(Array) and hash2.is_a?(Array)
        hash1.concat(hash2)
      else
        hash1.merge(hash2, &MERGER)
      end
    end

    module_function :merge
  end
end
