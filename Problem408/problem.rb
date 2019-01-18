def is_square?(x)
  (Math.sqrt(x) % 1).zero? && x != 0
end

# def dp(x,y,n)
#
#   if x > n || y > n
#     return 0
#   else
#     if $memo[x] != nil && $memo[x][y] != nil && $memo[x][y] != -1
#       return $memo[x][y]
#     else
#       if is_square?(x) && is_square?(y) && is_square?(x+y)
#         if $memo[x] == nil
#           $memo[x] = []
#         end
#         $memo[x][y] = 0
#         return 0
#       elsif x == n && y == n
#         if $memo[x] == nil
#           $memo[x] = []
#         end
#         $memo[x][y] = 1
#         return 1
#       else
#         if $memo[x] == nil
#           $memo[x] = []
#         end
#         $memo[x][y] = dp(x+1, y, n) + dp(x, y+1, n)
#         return $memo[x][y]
#       end
#     end
#   end
#
# end
#
# n = 16
# $memo = [[]]
# puts "#{dp(0,0,n) % 1000000007}"

n = 10000000
mod = 1000000007
memo = []
i = n
while i >= 0
  if memo[i] == nil
    memo[i] = []
  end
  j = n
  while j >= 0
    if is_square?(i) && is_square?(j) && is_square?(i+j)
      memo[i][j] = 0
    elsif i == n && j == n
      memo[i][j] = 0
    elsif i == n
      memo[i][j] = 1
      if memo[i][j+1] == 0 && j+1 != n
        memo[i][j] = 0
      end
    elsif j == n
      memo[i][j] = 1
      if memo[i+1][j] == 0 && i+1 != n
        memo[i][j] = 0
      end
    else
      memo[i][j] = memo[i+1][j] + memo[i][j+1]
    end
    j = j - 1
  end
  i = i - 1
end

puts "#{memo[0][0] % mod}"
