firstNumber = 999
results = []
while firstNumber >= 100
  secondNumber = 999
  while secondNumber >= 100

    product = firstNumber * secondNumber
    reversed_product = product.to_s.reverse.to_i

    # puts "#{product} and #{reversed_product}"

    if product == reversed_product
      results.push(product)
    end

    secondNumber = secondNumber - 1
  end
  firstNumber = firstNumber - 1
end

max_value = results.max
puts "#{max_value}"

