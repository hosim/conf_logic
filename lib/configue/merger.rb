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

    def merge(container1, container2)
      return container2 unless container1
      return container1 unless container2

      if container1.is_a?(Array) and container2.is_a?(Array)
        container1.concat(container2)
      else
        container1.merge(container2, &MERGER)
      end
    end

    module_function :merge
  end
end
