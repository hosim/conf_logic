# coding: utf-8

module Configue
  module Merger
    def merge(hash1, hash2)
      return hash2 unless hash1
      return hash1 unless hash2

      merger = ->(key, h1, h2) {
        if h1.is_a?(Hash) and h2.is_a?(Hash)
          h1.merge(h2, &merger)
        else
          h2
        end
      }

      hash1.merge(hash2, &merger)
    end

    module_function :merge
  end
end
