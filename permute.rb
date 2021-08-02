def permutations(array, index=0, stack=[])
  stack << array if index == array.size
  (index..array.size-1).each do |swap|
    array[index], array[swap] = array[swap], array[index]
    permutations(array, index+1, stack)
    array[index], array[swap] = array[swap], array[index]
  end
  stack
end

p permutations('ABC')