fibMap = []
fibMap[0] = 0
fibMap[1] = 1
puts "#{fibMap[0]}"
puts "#{fibMap[1]}"
sum = 0
for i in 2..4000000
  fibMap[i] = fibMap[i-1] + fibMap[i-2]
  if fibMap[i] > 4000000
    break
  end
  if fibMap[i] % 2 == 0
    # puts "#{fibMap[i]} is a fibonacci even number"
    sum = sum + fibMap[i]
  end
end

puts "#{sum}"