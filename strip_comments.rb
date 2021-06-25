
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