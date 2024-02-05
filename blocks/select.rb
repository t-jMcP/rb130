def select(arr)
  counter = 0
  return_arr = []

  loop do
    break if counter == arr.length
    current_element = arr[counter]
    return_arr << current_element if yield(current_element)
    counter += 1
  end

  return_arr
end

array = [1, 2, 3, 4, 5]

p select(array) { |num| num.odd? } # => [1, 3, 5]
p select(array) { |num| puts num } # => [], because "puts num" returns nil
p select(array) { |num| num + 1 } # => [1, 2, 3, 4, 5], because "num + 1" evaluates to true
 