# coding: utf-8

module Configue
  module ArrayNode
    def [](index)
      return nil unless @hash
      v = @hash[index]
      @hash[index] = self.class.new(v) if node?(v)
      @hash[index]
    end

    def last
      return nil unless @hash
      self[@hash.size - 1]
    end

    [ :first,
      :second,
      :third,
      :fourth,
      :fifth,
      :sixth,
      :seventh,
      :eighth,
      :ninth,
      :tenth,
    ].each_with_index do |m, n|
      define_method(m, -> { self[n] })
    end

    [ :&,
      :*,
      :+,
      :-,
      :|,
      :<=>,
      :==,
      :assoc,
      :at,
      :collect,
      :combination,
      :compact,
      :count,
      :cycle,
      :drop,
      :drop_while,
      :each,
      :each_index,
      :empty?,
      :eql?,
      :find_index,
      :flattern,
      :frozen?,
      :hash,
      :include?,
      :index,
      :join,
      :length,
      :map,
      :pack,
      :product,
      :reassoc,
      :reject,
      :repeated_combination,
      :repeated_permutation,
      :reverse,
      :rindex,
      :rotate,
      :sample,
      :select,
      :shuffle,
      :size,
      :slice,
      :sort,
      :take,
      :take_while,
      :to_a,
      :to_ary,
      :transpose,
      :uniq,
      :values_at,
      :zip,
    ].each do |m|
      define_method(m, ->(*args, &block) {
                      @hash.__send__(m, *args, &block)
                    })
    end
  end
end
