e_components = [2]
numerators = []

i = 0;
count = 1
n = 99
while i < n
  e_components.push(1)
  e_components.push(2 * count)
  e_components.push(1)

  count = count + 1
  i = i + 3
end

puts "#{e_components}"

numerators[0] = 2
numerators[1] = 3

i = 2
while i < e_components.length
  if e_components[i] != 1
    numerators[i] = numerators[i-1] * e_components[i] + numerators[i-2]
  else
    numerators[i] = numerators[i-1] + numerators[i-2]
  end
  i = i + 1
end

puts "#{numerators[n]}"

puts "#{numerators[n].to_s.chars.map(&:to_i).inject(0){|sum,x| sum + x }}"


