def reduce(arr, starting_val = nil)
  if starting_val.nil?
    accumulator = arr[0]
    counter = 1
  else
    accumulator = starting_val
    counter = 0
  end

  loop do
    break if counter == arr.length
    accumulator = yield(accumulator, arr[counter])
    counter += 1
  end

  accumulator
end


p reduce(['a', 'b', 'c']) { |acc, value| acc += value } # => 'abc'
p reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value } # => [1, 2, 'a', 'b']
