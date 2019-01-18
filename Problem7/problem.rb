def is_prime(i, list)
  list.each { |x|
    if i % x == 0
      return false
    end
  }
  return true
end

list = []
i = 2
count = 0
found = false

while !found
  if is_prime(i, list)
    list.push(i)
    count = count + 1
  end

  if count == 10001
    found = true
    puts "the value is #{list.pop()}"
  end
  i = i + 1

end

