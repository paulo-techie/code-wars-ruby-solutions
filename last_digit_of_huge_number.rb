# def last_digit(lst)
#   return 1 unless lst[0]
#   return 1 if lst.size == 2 && lst.all?{|n| n==0 }
#   return 1 if lst.size < 2 && lst[0] < 1
#   return 0 if lst.all?{|n| n==0 }
#   return (lst[-2]**lst[-1]).digits.first if lst.size < 3
#   return lst.reverse.reduce{|a, b| b**a}.digits.first if lst.all?{|n| n<10}
  
#   t = 0
#   lst.reverse.each_with_index do |n, i|
#     t = (n.digits[1].to_s + n.digits[0].to_s).to_i and next if i == 0
# #     n = (n.to_s.chars.reverse.join.to_s.to_i.to_s.reverse).to_i if n.digits.first == 0
# #     t = (t.to_s.chars.reverse.join.to_s.to_i.to_s.reverse).to_i if t.digits.first == 0
# #     p t
# #     p n
#     t = (n.digits[1].to_s + n.digits[0].to_s).to_i ** (t.digits[1].to_s + t.digits[0].to_s).to_i
# #     p t
#   end
#   p t.digits
#   t.digits.first

# end


# # def last_digit(lst)
  
# #   last_digit_pattern = {
# #     0 => [0], 1 => [1], 2 => [4,8,6,2], 3 => [9,7,1,3], 4 => [6,4],
# #     5 => [5], 6 => [6], 7 => [9,3,1,7], 8 => [8,4,2,6], 9 => [1,9]
# #     }

# #   pattern_size = {
# #     0 => 1, 1 => 1, 2 => 4, 3 => 4, 4 => 2, 5 => 1, 6 => 1, 7 => 4, 8 => 4, 9 => 2
# #     }

# #   return 1 unless lst[0]
# #   return 1 if lst.size == 2 && lst.all?{|n| n==0 }
# #   return 1 if lst.size < 2 && lst[0] < 1
# #   return 0 if lst.all?{|n| n==0 }
# #   return lst[0].digits.first if lst.size < 2
# #   return (lst[-2]**lst[-1]).digits.first if lst.size < 3 
# #   return lst.reverse.reduce{|a, b| b**a}.digits.first if lst.all?{|n| n<10}
  
# #   t = 0
# #   lst.reverse.each_with_index do |n, i|
# #     next unless t
# #     t = n.digits.first and next if i == 0
# #     t = 0 and next if n == 0
# #     p t
# #     if pattern_size[n.digits.first] == 1
# #       t = (n.digits.first)
# #           p t
# #       next
# #     end
# #     p pattern_size[n.digits.first] 
# #     p t
# #     p n
# #     p n.digits.first
# #     p t
# # #     t = (n**t).digits.first and next if n.digits.size < 3
# #     t = t%pattern_size[n.digits.first]
# #     t = last_digit_pattern[n.digits.first][-2] and next if t == 0 
# #     t = last_digit_pattern[n.digits.first][t]
# #     p t
# #   end
# #   t
# # end

# ## Passess all test cases except 'attempt'

# def last_digit(lst)
  
#   last_digit_pattern = {
#     0 => [0], 1 => [1], 2 => [4,8,6,2], 3 => [9,7,1,3], 4 => [6,4],
#     5 => [5], 6 => [6], 7 => [9,3,1,7], 8 => [8,4,2,6], 9 => [1,9]
#     }

#   pattern_size = {
#     0 => 1, 1 => 1, 2 => 4, 3 => 4, 4 => 2, 5 => 1, 6 => 1, 7 => 4, 8 => 4, 9 => 2
#     }

#   return 1 unless lst[0]
#   return 1 if lst.size == 2 && lst.all?{|n| n==0 }
#   return 1 if lst.size < 2 && lst[0] < 1
#   return 0 if lst.all?{|n| n==0 }
#   return lst[0].digits.first if lst.size < 2
#   return (lst[-2]**lst[-1]).digits.first if lst.size < 3 
#   return lst.reverse.reduce{|a, b| b**a}.digits.first if lst.all?{|n| n<10}
  
#   t = 0
#   lst.reverse.each_with_index do |n, i|
#     next unless t
#     t = n.digits.first and next if i == 0
#     t = 0 and next if n == 0
#     p t
#     if pattern_size[n.digits.first] == 1
#       t = (n.digits.first)
#           p t
#       next
#     end
#     p pattern_size[n.digits.first] 
#     p t
#     p n
#     p n.digits.first
#     p t
# #     t = (n**t).digits.first and next if n.digits.size < 3
#     t = t%pattern_size[n.digits.first]
#     t = last_digit_pattern[n.digits.first][-2] and next if t == 0 
#     t = last_digit_pattern[n.digits.first][t]
#     p t
#   end
#   t
# end

def last_digit(lst)
  last_digit_pattern = {
    0 => [0], 1 => [1], 2 => [2,4,8,6], 3 => [3,9,7,1], 4 => [4,6], 
    5 => [5], 6 => [6], 7 => [7,9,3,1], 8 => [8,4,2,6], 9 => [9,1]
    }

  pattern_size = {
    0 => 1, 1 => 1, 2 => 4, 3 => 4, 4 => 2, 5 => 1, 6 => 1, 7 => 4, 8 => 4, 9 => 2
    }
  
  
  return 1 unless lst[0]
  return 1 if lst.size == 2 && lst.all?{|n| n==0 }
  return 1 if lst.size < 2 && lst[0] < 1
  return 0 if lst.all?{|n| n==0 }
  return lst[0].digits.first if lst.size < 2
  return (lst[-2]**lst[-1]).digits.first if lst.size < 3 

  return lst.reverse.reduce{|a, b| b**a}.to_s(16).to_i(16).digits.first if lst.all?{|j| j < 11 }
  
  t = 0
  lst.reverse.each_with_index do |n, i|
    p n
    p t
    t = n and next if i == 0 || t == 1
    t = 0 and next if n.digits.first == 0
    t = last_digit_pattern[n.digits.first][-1] and next if t == 0
#     t = t.digits.first and next if pattern_size[t.digits.first] == 1
    t = last_digit_pattern[n.digits.first][-1] and next if t%pattern_size[n.digits.first] == 0
    t = last_digit_pattern[n.digits.first][(t%pattern_size[n.digits.first])+1]
  end

  t
end

[
        [[], 1],
        [[0, 0], 1],
        [[0, 0, 0], 0],
        [[1, 2], 1],
        [[3, 4, 5], 1],
        [[4, 3, 6], 4],
#         [[7, 6, 21], 1],
        [[12, 30, 21], 6],
#         [[2, 2, 2, 0], 4],
        [[937640, 767456, 981242], 0],
#         [[123232, 694022, 140249], 6],
#         [[499942, 898102, 846073], 6]