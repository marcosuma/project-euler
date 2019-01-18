x = 600851475143
i = 2
factors = []
while i <= x
  if (x % i == 0)
    if factors.last() != i
      factors.push(i)
    end
    x = x / i
    i = 2
  else
    i = i + 1
  end
end

puts "#{factors.last()}"