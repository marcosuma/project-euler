
min = 1
max = 100

sum = 0

for i in min..max
  _min = i + 1
  for j in _min..max
    sum = sum + (2 * i * j)
  end

end

puts "#{sum}"

