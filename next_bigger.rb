# Description:
# Create a function that takes a positive integer and returns the next bigger number that can be formed by rearranging its digits. For example:

# 12 ==> 21
# 513 ==> 531
# 2017 ==> 2071
# nextBigger(num: 12)   // returns 21
# nextBigger(num: 513)  // returns 531
# nextBigger(num: 2017) // returns 2071
# If the digits can't be rearranged to form a bigger number, return -1 (or nil in Swift):

# 9 ==> -1
# 111 ==> -1
# 531 ==> -1
# nextBigger(num: 9)   // returns nil
# nextBigger(num: 111) // returns nil
# nextBigger(num: 531) // returns nil

def next_bigger(n)
  n = n.to_s
  n_length = n.size
  return -1 if n_length <= 1
  return n.chars.reverse.join.to_i  if n_length <= 2
  (n_length-1).downto(1) do |i|
    if n[i] > n[i-1]
      f = n.chars[i..n_length-1].sort.find_index{ |f| n[f] > n[i-1] } 
      n = n.chars[0..i-1].join.concat(n.chars[i..n_length-1].sort.join)
      n[i-1], n[f+i] = n[f+i], n[i-1]
      return n.chars[0..i-1].join.concat(n.chars[i..n_length-1].sort.join).to_i
    end
   end
  -1
end
