def times(num)
  iterator = 0

  loop do
    break if iterator == num
    yield(iterator)
    iterator += 1
  end

  num
end

p times(5) { |num| puts num }
# 0
# 1
# 2
# 3
# 4
# => 5
