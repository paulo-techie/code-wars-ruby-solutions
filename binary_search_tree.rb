def binary_search(n, arr)
  middle = arr[arr.length / 2]
  if middle == n
    return true
  elsif middle < n
    binary_search(n, arr[0..middle])
  else
    binary_search(n, arr[middle..arr.length-1])
  end
end 