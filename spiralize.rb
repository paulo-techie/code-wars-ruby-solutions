# Description:
# Your task, is to create a NxN spiral with a given size.

# For example, spiral with size 5 should look like this:

# 00000
# ....0
# 000.0
# 0...0
# 00000
# and with the size 10:

# 0000000000
# .........0
# 00000000.0
# 0......0.0
# 0.0000.0.0
# 0.0..0.0.0
# 0.0....0.0
# 0.000000.0
# 0........0
# 0000000000
# Return value should contain array of arrays, of 0 and 1, for example for given size 5 result should be:

# [[1,1,1,1,1],[0,0,0,0,1],[1,1,1,0,1],[1,0,0,0,1],[1,1,1,1,1]]
# [[1,1,1,1,1],[0,0,0,0,1],[1,1,1,0,1],[1,0,0,0,1],[1,1,1,1,1]]
# [1 1 1 1 1; 0 0 0 0 1; 1 1 1 0 1; 1 0 0 0 1; 1 1 1 1 1]
# Because of the edge-cases for tiny spirals, the size will be at least 5.

# General rule-of-a-thumb is, that the snake made with '1' cannot touch to itself.

def spiralize(size)
  matrix = []
  k = size
  pos = 0
  (size*size).times{ |i| matrix[i] = i < size ? 1 : 0 }
  pos = - 1
  loop do  # loop spiral downwards
    (size).times do |i| # down
      pos += k if pos < (k*k)
      matrix[pos] = 1 if matrix[pos-1] && matrix[pos-1] == 0 # edge case
    end
      (size-1).times do |i| # left
        pos -= 1
        matrix[pos] = 1 unless matrix[pos-k] && matrix[pos-k] == 1 # edge case
      end
        size -= 2
        break if size < 2
        (size-1).times do |i| # up
          pos -= k
          matrix[pos] = 1
        end
          break if size < 3
          (size-1).times do |i| # right
              pos += 1
              matrix[pos] = 1
            end
      size -= 2
      pos -= k
  end
  
  
  # output the matrix
  output = []
  temp = []
  k.times do |i|
    temp = []
    k.times do |j|
      temp << matrix[j+k*i]
    end
    output << temp
  end
    
  output
end
