
# Description:
# The maximum sum subarray problem consists in finding the maximum sum of a contiguous subsequence in an array or list of integers:

# maxSequence [-2, 1, -3, 4, -1, 2, 1, -5, 4]
# -- should be 6: [4, -1, 2, 1]
# maxSequence([-2, 1, -3, 4, -1, 2, 1, -5, 4])
# // should be 6: [4, -1, 2, 1]
# max_sequence([-2, 1, -3, 4, -1, 2, 1, -5, 4])
# # should be 6: [4, -1, 2, 1]
# (max-sequence [-2, 1, -3, 4, -1, 2, 1, -5, 4])
# ;; should be 6: [4, -1, 2, 1]
# Max.sequence(new int[]{-2, 1, -3, 4, -1, 2, 1, -5, 4});
# // should be 6: {4, -1, 2, 1}
# maxSequence(listOf(-2, 1, -3, 4, -1, 2, 1, -5, 4));
# // should be 6: listOf(4, -1, 2, 1)
# maxSequence({-2, 1, -3, 4, -1, 2, 1, -5, 4}, 9)
# // should return 6, from sub-array: {4, -1, 2, 1}
# maxSequence({-2, 1, -3, 4, -1, 2, 1, -5, 4});
# //should be 6: {4, -1, 2, 1}
# Easy case is when the list is made up of only positive numbers and the maximum sum is the sum of the whole array. If the list is made up of only negative numbers, return 0 instead.

# Empty list is considered to have zero greatest sum. Note that the empty list or array is also a valid sublist/subarray.


def max_sequence(arr)
  return 0 if arr.length == 0 || arr.all?{|a| a<0 }
  temp = arr.max()
  
  (arr.length).times do |i|
    arr[0..i].reduce do |x,y|
      temp = x+y if x+y > temp
      x+y
    end
    arr[i..(arr.length)].reduce do |x,y|
      temp = x+y if x+y > temp
      x+y
    end
  end
  
  temp
  
end

p max_sequence [-2, 1, -3, 4, -1, 2, 1, -5, 4]