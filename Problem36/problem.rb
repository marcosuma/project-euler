s = "000000000"

def f(s, i)
  if i == s.length()
    # check if 10-base is palindrome

    # first add the 1 at the end of the string
    s += "1"
    puts "s = #{s}"

    # compute the 10-base number
    # the string is guaranteed to be 10 digit long
    pow = 9
    number = 0
    while (9 - pow < 10)
      number = number + (s[9 - pow].to_i * 2 ** pow)
      pow = pow - 1
    end
    number = number.to_s
    puts "number = #{number}"

    # now compute the mirrored binary string
    i = s.length - 1
    mirrS = ""
    while i >= 0
      mirrS += s[i]
      i = i - 1
    end
    puts "mirrS = #{mirrS}"

    # compute the 10-base number
    # the string is guaranteed to be 10 digit long
    pow = 9
    mirrNumber = 0
    while (9 - pow < 10)
      mirrNumber += mirrS[9 - pow].to_i * 2 ** pow
      pow = pow - 1
    end
    mirrNumber = mirrNumber.to_s
    puts "mirrNumber = #{mirrNumber}"

    # check if number and mirrNumber together form a palindrome number
    if number.length != mirrNumber.length
      return []
    end

    len = number.length - 1
    i = 0
    while i < len
      if number[i] != mirrNumber[len - i]
        return []
      end
      i = i + 1
    end

    mirrNumber += number
    puts "result = #{mirrNumber}"
    return [mirrNumber]
  end

  # set 0 first and move to next pointer
  list = f(s, i + 1)
  # then set 1 and move to next pointer
  s[i] = "1"
  list.push(f(s, i + 1).flatten!)
  return list
end


arr = f(s,0)
puts "#{arr}"