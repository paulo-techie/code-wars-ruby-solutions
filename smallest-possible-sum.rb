# return smallest possible sum of all numbers in Array
def solution(numbers)
  return nil unless numbers[0]
  return nil if numbers.index(0)
  return numbers[0] if numbers.size < 2
  loop do
    f = numbers.uniq.max(2)
    m = numbers.index(f[0])
    n = numbers.index(f[-1])
    break if f.size < 2
      numbers[m] -= numbers[n]
  end
  numbers.reduce(:+)
end

p solution([7,21,55])