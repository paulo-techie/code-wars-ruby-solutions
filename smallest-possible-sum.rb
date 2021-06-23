# return smallest possible sum of all numbers in Array
def solution(numbers)
  return numbers if numbers.size < 2
  rotate = true
  while rotate == true
    rotate = false
    (0..numbers.size-2).each do |i|
        if numbers[i] > numbers[i+1] && numbers[i+1] > 0
          numbers[i] -= numbers[i+1]
          rotate = true
        end
    end
    (numbers.size-1).downto(1) do |i|
        if numbers[i] > numbers[i-1] && numbers[i-1] > 0
          numbers[i] -= numbers[i-1]
          rotate = true
        end
    end
  end
  numbers.reduce(:+)
end

p solution([1,21,55])

=begin
def solution(numbers)
  return nil unless numbers[0]
  return nil if numbers.index(0)
  return numbers[0] if numbers.size < 2

  f = numbers.uniq.max(2)
  g = numbers.min
  t = numbers.size

  f[1] = (f[0]).gcd(g)
  f[0] = g
  p "#{f[0]},,,#{f[1]}"
  e = f[0] <=> f[1]
  p e
  return f[1]*t if f[1] == f[0]

  loop do
    e = f[0] <=> f[1]
    if e == 1
      m, n  = 0, 1
    elsif e == -1
      m, n = 1, 0
    else 
      break
    end
    f[m] -= f[n]
  end
  f[0]*t
end
=end