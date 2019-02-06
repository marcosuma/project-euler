# Let's call a lattice point (x, y) inadmissible if x, y and x + y are all positive perfect squares.
# For example, (9, 16) is inadmissible, while (0, 4), (3, 1) and (9, 4) are not.
#
# Consider a path from point (x1, y1) to point (x2, y2) using only unit steps north or east.
# Let's call such a path admissible if none of its intermediate points are inadmissible.
#
#     Let P(n) be the number of admissible paths from (0, 0) to (n, n).
#     It can be verified that P(5) = 252, P(16) = 596994440 and P(1000) mod 1 000 000 007 = 341920854.
#
#     Find P(10 000 000) mod 1 000 000 007.
#
#
# Credits to https://github.com/lgarron/project-euler/blob/master/408.c and to https://github.com/nicolagi

def extended_gcd(a, b)

  previous_r = a
  r = b
  previous_s = 1
  s = 0
  previous_t = 0
  t = 1
  while r > 0
    quotient = previous_r / r
    remainder = previous_r % r

    previous_r = r
    r = remainder

    new_s = previous_s - quotient * s
    previous_s = s
    s = new_s

    new_t = previous_t - quotient * t
    previous_t = t
    t = new_t

  end

  return [previous_r, previous_s, previous_t]
end

def times_mod(a, b)
  return (a * b) % $mod
end

def minus_mod(a, b)
  return (a - b + $mod) % $mod
end

def init_factorial_array
  $factorial_array_mod[0] = 1
  i = 1
  while i < (2 * $n + 1)
    $factorial_array_mod[i] = times_mod($factorial_array_mod[i - 1], i)

    i = i + 1
  end
end

def central_binomial_coefficient(end_x, end_y, start_x, start_y)
  # puts "central_binomial_coefficient(...)"

  # puts "end_x = #{end_x}"
  # puts "end_y = #{end_y}"
  # puts "start_x = #{start_x}"
  # puts "start_y = #{start_y}"

  diff_x = minus_mod(end_x, start_x)
  diff_y = minus_mod(end_y, start_y)

  n = diff_x + diff_y
  k = diff_y
  nMod = n % $mod
  kMod = k % $mod
  nMinusKMod = minus_mod(n, k)


  # puts "diff_x = #{diff_x}"
  # puts "diff_y = #{diff_y}"

  if diff_x == 0 || diff_y == 0
    return 1
  end

  num = $factorial_array_mod[nMod]
  den_1 = $factorial_array_mod[kMod]
  den_2 = $factorial_array_mod[nMinusKMod]
  den = times_mod(den_1, den_2)
  inv_den = extended_gcd(den, $mod)[1]

  # puts "num = #{num}"
  # puts "den_1 = #{den_1}"
  # puts "den_2 = #{den_2}"
  # puts "den = #{den}"
  # puts "inv_den = #{inv_den}"
  return times_mod(num, inv_den)
end

# https://en.wikipedia.org/wiki/Pythagorean_triple
def init_pythagorean_triple_x_y(max_root)
  index = 0
  for i in 1..max_root
    for j in 1..i
      if extended_gcd(i,j)[0] == 1 && (i - j) % 2 == 1
        a = i*i - j*j
        b = 2 * i * j

        k = 1
        while true
          x = a * a * k * k
          y = b * b * k * k

          if x > $n || y > $n
            break
          end

          # puts "(#{i}, #{j})"
          # puts "(#{x}, #{y})"
          $pythagorean_triple_x_y[index] = [x, y]
          index = index + 1
          $pythagorean_triple_x_y[index] = [y, x]
          index = index + 1

          k = k + 1
        end
      end
    end
  end
end

$mod = 1000000007
$n = 10000000
$pythagorean_triple_x_y = []
$factorial_array_mod = []
$admissible_paths_to_the_inadmissible_point = {}

init_factorial_array()
init_pythagorean_triple_x_y(64)

# puts "#{$pythagorean_triple_x_y}"

def compute_admissible_paths(dest_x, dest_y, orig_x, orig_y)
  x = 0
  y = 1
  total = central_binomial_coefficient(dest_x, dest_y, orig_x, orig_y)
  # puts "dest_x = #{dest_x}"
  # puts "dest_y = #{dest_y}"
  # puts "orig_x = #{orig_x}"
  # puts "orig_y = #{orig_y}"
  $pythagorean_triple_x_y.each {|point|
    # puts "point[x] = #{point[x]}"
    # puts "point[y] = #{point[y]}"
    if !(point[x] > dest_x || point[y] > dest_y || (point[x] == dest_x && point[y] == dest_y))

        paths_from_the_inadmissible_point = central_binomial_coefficient(dest_x, dest_y, point[x], point[y])
        # puts "paths_from_the_inadmissible_point = #{paths_from_the_inadmissible_point}"
        if $admissible_paths_to_the_inadmissible_point[[point[x], point[y], orig_x, orig_y]] != nil
          admissible_paths_to_the_inadmissible_point = $admissible_paths_to_the_inadmissible_point[[point[x], point[y], orig_x, orig_y]]
        else
          admissible_paths_to_the_inadmissible_point = compute_admissible_paths(point[x], point[y], orig_x, orig_y)
        end
        # puts "admissible_paths_to_the_inadmissible_point = #{admissible_paths_to_the_inadmissible_point}"
        paths_to_remove = times_mod(paths_from_the_inadmissible_point, admissible_paths_to_the_inadmissible_point)
        $admissible_paths_to_the_inadmissible_point[[point[x], point[y], orig_x, orig_y]] = admissible_paths_to_the_inadmissible_point
        $admissible_paths_to_the_inadmissible_point[[point[y], point[x], orig_x, orig_y]] = admissible_paths_to_the_inadmissible_point

      total = minus_mod(total, paths_to_remove)

    end
  }

  return total
end

total = compute_admissible_paths($n, $n, 0, 0)
puts "#{total}"
