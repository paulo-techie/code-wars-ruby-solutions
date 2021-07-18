def last_digit(lst)
  last_digit_pattern = {
    0 => [0], 1 => [1], 2 => [2,4,8,6], 3 => [3,9,7,1], 4 => [4,6], 
    5 => [5], 6 => [6], 7 => [7,9,3,1], 8 => [8,4,2,6], 9 => [9,1]
    }
  p lst
  return 1 unless lst[0]
  return lst[0].digits.first if lst.size < 2
  return 1 if lst.size == 2 && lst.all?{|n| n==0 }
  return 0 if lst.all?{|n| n==0 }
  return 1 if lst.size < 3 && lst[1] < 1
  return lst[0].digits.first  if lst.size < 2
  return lst[0].digits.first  if last_digit_pattern[lst[0].digits.first].size == 1
#   return last_digit_pattern[lst[0].digits.first][-1] if lst[1].digits.first == 0
  return lst[0].digits.first if lst[1] == 0 && lst[2] == 0
  return (lst[-2]**lst[-1]).digits.first if lst.size < 3
  return lst.reverse.reduce{|a, b| b**a}.digits.first if lst.all?{|j| j < 11 } && lst.size < 5
  lst = lst[0..4]
  lst.each_with_index do |a,i|
    break if i == lst.size
    a = lst.pop
    b = lst.pop.digits.first
    lst.push(last_digit_pattern[b.digits.first][(a%last_digit_pattern[b.digits.first].size)-1])
  end
  p lst[0]
end