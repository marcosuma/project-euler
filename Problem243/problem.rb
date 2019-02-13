# https://projecteuler.net/problem=243
#
# A positive fraction whose numerator is less than its denominator is called a proper fraction.
# For any denominator, d, there will be d−1 proper fractions; for example, with d = 12:
#       1/12 , 2/12 , 3/12 , 4/12 , 5/12 , 6/12 , 7/12 , 8/12 , 9/12 , 10/12 , 11/12 .
# We shall call a fraction that cannot be cancelled down a resilient fraction.
# Furthermore we shall define the resilience of a denominator, R(d), to be the ratio of its proper fractions that are resilient; for example, R(12) = 4/11 .
# In fact, d = 12 is the smallest denominator having a resilience R(d) < 4/10 .
# Find the smallest denominator d, having a resilience R(d) < 15499/94744 .


def find_next_prime(prev_p)
  p = prev_p + 1
  while true
    i = 2
    prime = true
    while i < p
      if p % i == 0
        prime = false
        break
      end
      i = i + 1
    end
    if prime
      break
    end
    p = p + 1
  end
  p
end

# Credits to https://github.com/nayuki/Project-Euler-solutions/blob/master/python/p243.py which helped me finding the solution to the problem.
#
# The algorithm is based on the concept of euler's totient function: https://en.wikipedia.org/wiki/Euler%27s_totient_function
# It can be demonstrated that d is a potential solution iff it is composed by all prime numbers between 1 and a certain value n
# If a value d is missing even a prime number between 1 and n, then for sure it won't be part of the solution.
# We can demonstrate that by calculating the totient function of two numbers d and d' with these two different characteristics
# and then we can demonstrate that R(d) is a non-decreasing function therefore what we are saying is true.
# The obstacle is that we don't know with what frequency each prime number is occurring in the d value, which is the solution to the problem.
# So we start defining an equivalent R'(d) function that helps defining us the lower boundary for the solution d.
# From that value we keep trying multiplying all numbers by iterating from 2 to p, which is the biggest prime numbers found in the potential solution d.
NUM = 15499.0
DEN = 94744.0
p = 1
d = 1
totient = 1
while true
  p = find_next_prime(p)
  d = d * p
  totient = totient * (p - 1)
  if totient.to_f / d < (NUM * 1.0 / DEN)
    found = false
    i = 2
    while i < p
      num = totient * i
      den = d * i
      if num.to_f / (den - 1) < (NUM * 1.0 / DEN)
        puts "#{den}"
        found = true
        break
      end

      i = i + 1
    end

    if found
      break
    end
  end
end