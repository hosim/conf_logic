# coding: utf-8

module Configue
  module ArrayNode
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
      :[],
      :all?,
      :any?,
      :assoc,
      :at,
      :chunk,
      :collect,
      :combination,
      :compact,
      :count,
      :cycle,
      :detect,
      :drop,
      :drop_while,
      :each,
      :each_index,
      :each_slice,
      :each_with_index,
      :each_with_object,
      :empty?,
      :entries,
      :eql?,
      :fetch,
      :find,
      :find_all,
      :find_index,
      :flat_map,
      :flattern,
      :frozen?,
      :grep,
      :group_by,
      :hash,
      :include?,
      :index,
      :inject,
      :join,
      :length,
      :map,
      :max,
      :max_by,
      :member?,
      :min,
      :min_by,
      :minmax,
      :minmax_by,
      :none?,
      :one?,
      :pack,
      :partition,
      :product,
      :reassoc,
      :reduce,
      :reject,
      :repeated_combination,
      :repeated_permutation,
      :reverse,
      :reverse_each,
      :rindex,
      :rotate,
      :sample,
      :select,
      :shuffle,
      :size,
      :slice,
      :slice_before,
      :sort,
      :sort_by,
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
                      @container.__send__(m, *args, &block)
                    })
    end
  end
end
