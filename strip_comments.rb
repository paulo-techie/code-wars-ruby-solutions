# Description:
# Complete the solution so that it strips all text that follows any of a set of comment markers passed in. Any whitespace at the end of the line should also be stripped out.

# Example:

# Given an input string of:

# apples, pears # and bananas
# grapes
# bananas !apples
# The output expected would be:

# apples, pears
# grapes
# bananas
# The code would be called like so:

# var result = solution("apples, pears # and bananas\ngrapes\nbananas !apples", ["#", "!"])
# // result should == "apples, pears\ngrapes\nbananas"
# var result = solution("apples, pears # and bananas\ngrapes\nbananas !apples", charArrayOf('#', '!'))
# // result should == "apples, pears\ngrapes\nbananas"
# result = solution("apples, pears # and bananas\ngrapes\nbananas !apples", ["#", "!"])
# # result should == "apples, pears\nograpes\nbananas"
# result = solution("apples, pears # and bananas\ngrapes\nbananas !apples", ["#", "!"])
# # result should == "apples, pears\ngrapes\nbananas"
# result = solution("apples, pears # and bananas\ngrapes\nbananas !apples", ["#", "!"])
# # result should == "apples, pears\ngrapes\nbananas"
# result = solution("apples, pears # and bananas\ngrapes\nbananas !apples", ["#", "!"])
# # result should == "apples, pears\ngrapes\nbananas"
# string stripped = StripCommentsSolution.StripComments("apples, pears # and bananas\ngrapes\nbananas !apples", new [] { "#", "!" })
# // result should == "apples, pears\ngrapes\nbananas"
# result = stripcomments("apples, pears # and bananas\ngrapes\nbananas !apples", ["#", "!"])
# # result should == "apples, pears\ngrapes\nbananas"

def solution(input, markers)
  result = ""
  input = input.split("\n")
    input.each do |i|  
      k = i.chars.find_index(markers[0]) || k = i.chars.find_index(markers[1])
      k = i.length unless k
      result += i.chars[0..k-1].join.strip + "\n"
    end
  result.strip
end

p solution("apples, pears # and bananas\ngrapes\nbananas !apples", ["#", "!"])
