# https://projecteuler.net/problem=243
#
# A positive fraction whose numerator is less than its denominator is called a proper fraction.
# For any denominator, d, there will be d−1 proper fractions; for example, with d = 12:
#       1/12 , 2/12 , 3/12 , 4/12 , 5/12 , 6/12 , 7/12 , 8/12 , 9/12 , 10/12 , 11/12 .
# We shall call a fraction that cannot be cancelled down a resilient fraction.
# Furthermore we shall define the resilience of a denominator, R(d), to be the ratio of its proper fractions that are resilient; for example, R(12) = 4/11 .
# In fact, d = 12 is the smallest denominator having a resilience R(d) < 4/10 .
# Find the smallest denominator d, having a resilience R(d) < 15499/94744 .


def gcd(a, b)
  if a == b
    return [a]
  end

  list = {}
  while a != b
    if a > b
      list[[a-b, b].max] = true
      a = a - b
    elsif a < b
      list[[b-a, a].max] = true
      b = b - a
    end
  end

  if a == 1
    return {}
  end
  return list
end

# puts "#{gcd(76406500, 625)}"

target = 15499
d = 94744
count = d - 1
while true
  # puts "d: #{d}"
  i = 2
  excludedNumbers = {}
  while i < d / 2 + 1
    if excludedNumbers[i] != true

      list = gcd(d, i)
      count = count - list.size
      # puts "#{i}: #{list} --> count = #{count}"
      excludedNumbers.merge! list
    end


    i = i + 1
  end

  puts "count is #{count}"
  puts "d is #{d}"
  if count <= target
    break
  end
  # 0.163588195558558
  # if (count * 1.0 / d) < 0.1635
  #   puts "breaking.. #{count / d}"
  #   break
  # end

  d = d + 1
  count = d - 1
end

puts "#{count}"
puts "#{d}"


