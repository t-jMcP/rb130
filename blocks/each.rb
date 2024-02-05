def each(arr)
  counter = 0

  loop do
    break if counter == arr.length
    yield(arr[counter])
    counter += 1
  end

  arr
end

p each([1, 2, 3]) { |num| puts num }
# 1
# 2
# 3
#=> [1, 2, 3]
