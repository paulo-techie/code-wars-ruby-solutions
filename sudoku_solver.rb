
# Description:
# Write a function that will solve a 9x9 Sudoku puzzle. The function will take one argument consisting of the 2D puzzle array, with the value 0 representing an unknown square.

# The Sudokus tested against your function will be "easy" (i.e. determinable; there will be no need to assume and test possibilities on unknowns) and can be solved with a brute-force approach.

# For Sudoku rules, see the Wikipedia article.

# puzzle = [[5,3,0,0,7,0,0,0,0],
#           [6,0,0,1,9,5,0,0,0],
#           [0,9,8,0,0,0,0,6,0],
#           [8,0,0,0,6,0,0,0,3],
#           [4,0,0,8,0,3,0,0,1],
#           [7,0,0,0,2,0,0,0,6],
#           [0,6,0,0,0,0,2,8,0],
#           [0,0,0,4,1,9,0,0,5],
#           [0,0,0,0,8,0,0,7,9]]

# sudoku(puzzle)
# # Should return
#  [[5,3,4,6,7,8,9,1,2],
#   [6,7,2,1,9,5,3,4,8],
#   [1,9,8,3,4,2,5,6,7],
#   [8,5,9,7,6,1,4,2,3],
#   [4,2,6,8,5,3,7,9,1],
#   [7,1,3,9,2,4,8,5,6],
#   [9,6,1,5,3,7,2,8,4],
#   [2,8,7,4,1,9,6,3,5],
#   [3,4,5,2,8,6,1,7,9]]
# var puzzle = [
#             [5,3,0,0,7,0,0,0,0],
#             [6,0,0,1,9,5,0,0,0],
#             [0,9,8,0,0,0,0,6,0],
#             [8,0,0,0,6,0,0,0,3],
#             [4,0,0,8,0,3,0,0,1],
#             [7,0,0,0,2,0,0,0,6],
#             [0,6,0,0,0,0,2,8,0],
#             [0,0,0,4,1,9,0,0,5],
#             [0,0,0,0,8,0,0,7,9]];

# sudoku(puzzle);
# /* Should return
# [[5,3,4,6,7,8,9,1,2],
# [6,7,2,1,9,5,3,4,8],
# [1,9,8,3,4,2,5,6,7],
# [8,5,9,7,6,1,4,2,3],
# [4,2,6,8,5,3,7,9,1],
# [7,1,3,9,2,4,8,5,6],
# [9,6,1,5,3,7,2,8,4],
# [2,8,7,4,1,9,6,3,5],
# [3,4,5,2,8,6,1,7,9]] 
# sudoku([
#   [5,3,0,0,7,0,0,0,0],
#   [6,0,0,1,9,5,0,0,0],
#   [0,9,8,0,0,0,0,6,0],
#   [8,0,0,0,6,0,0,0,3],
#   [4,0,0,8,0,3,0,0,1],
#   [7,0,0,0,2,0,0,0,6],
#   [0,6,0,0,0,0,2,8,0],
#   [0,0,0,4,1,9,0,0,5],
#   [0,0,0,0,8,0,0,7,9]
# ]); /* => [
#   [5,3,4,6,7,8,9,1,2],
#   [6,7,2,1,9,5,3,4,8],
#   [1,9,8,3,4,2,5,6,7],
#   [8,5,9,7,6,1,4,2,3],
#   [4,2,6,8,5,3,7,9,1],
#   [7,1,3,9,2,4,8,5,6],
#   [9,6,1,5,3,7,2,8,4],
#   [2,8,7,4,1,9,6,3,5],
#   [3,4,5,2,8,6,1,7,9]
# ] */
# puzzle = [[5,3,0,0,7,0,0,0,0],
#           [6,0,0,1,9,5,0,0,0],
#           [0,9,8,0,0,0,0,6,0],
#           [8,0,0,0,6,0,0,0,3],
#           [4,0,0,8,0,3,0,0,1],
#           [7,0,0,0,2,0,0,0,6],
#           [0,6,0,0,0,0,2,8,0],
#           [0,0,0,4,1,9,0,0,5],
#           [0,0,0,0,8,0,0,7,9]]

# sudoku puzzle
# {- Should return
# [[5,3,4,6,7,8,9,1,2],
#  [6,7,2,1,9,5,3,4,8],
#  [1,9,8,3,4,2,5,6,7],
#  [8,5,9,7,6,1,4,2,3],
#  [4,2,6,8,5,3,7,9,1],
#  [7,1,3,9,2,4,8,5,6],
#  [9,6,1,5,3,7,2,8,4],
#  [2,8,7,4,1,9,6,3,5],
#  [3,4,5,2,8,6,1,7,9]]
# -}

def sudoku(puzzle)
  quad1, quad2, quad3, quad4, quad5, quad6, quad7, quad8, quad9, col_array = [],[],[],[],[],[],[],[],[],[]
  9.times do |row|   # new array with flipped columns and rows
      column = []
    9.times do |col|
      column << puzzle[col][row]
          if col < 3 && row < 3
            quad1 << puzzle[row][col] unless puzzle[row][col] == 0
            elsif col < 6 && row < 3
              quad2 << puzzle[row][col] unless puzzle[row][col] == 0
            elsif col < 9 && row < 3
              quad3 << puzzle[row][col] unless puzzle[row][col] == 0
            elsif col < 3 && row < 6
              quad4 << puzzle[row][col] unless puzzle[row][col] == 0
            elsif col < 6 && row < 6
              quad5 << puzzle[row][col] unless puzzle[row][col] == 0
            elsif col < 9 && row < 6
              quad6 << puzzle[row][col] unless puzzle[row][col] == 0  
            elsif col < 3 && row < 9
              quad7 << puzzle[row][col] unless puzzle[row][col] == 0
            elsif col < 6 && row < 9
              quad8 << puzzle[row][col] unless puzzle[row][col] == 0
            elsif col < 9 && row < 9
              quad9 << puzzle[row][col] unless puzzle[row][col] == 0
          end
    end
    col_array << column
  end

  loop do
    insertion = true
    9.times do |col|
      val_list = []
      tmp_list = []
      9.times do |row|
        if col_array[col][row] == 0
          insertion = false
          tmp_list = (1..9).select{|s| !(puzzle[row].include?s)}
          tmp_list = tmp_list.select{|s| !(col_array[col].include?s)}
          if col < 3 && row < 3
              tmp_list = tmp_list.select{|s| !(quad1.include?s)}
            elsif col < 6 && row < 3
              tmp_list = tmp_list.select{|s| !(quad2.include?s)}
            elsif col < 9 && row < 3
              tmp_list = tmp_list.select{|s| !(quad3.include?s)}
            elsif col < 3 && row < 6
              tmp_list = tmp_list.select{|s| !(quad4.include?s)}
            elsif col < 6 && row < 6
              tmp_list = tmp_list.select{|s| !(quad5.include?s)}
            elsif col < 9 && row < 6
              tmp_list = tmp_list.select{|s| !(quad6.include?s)}
            elsif col < 3 && row < 9
              tmp_list = tmp_list.select{|s| !(quad7.include?s)}
            elsif col < 6 && row < 9
              tmp_list = tmp_list.select{|s| !(quad8.include?s)}
            elsif col < 9 && row < 9
              tmp_list = tmp_list.select{|s| !(quad9.include?s)}
          end
          val_list << tmp_list
          if tmp_list.size == 1
              col_array[col][row] = puzzle[row][col] = tmp_list[0]
              if col < 3 && row < 3
                quad1 << col_array[col][row]
                elsif col < 6 && row < 3
                  quad2 << col_array[col][row]
                elsif col < 9 && row < 3
                  quad3 << col_array[col][row]
                elsif col < 3 && row < 6
                  quad4 << col_array[col][row]
                elsif col < 6 && row < 6
                  quad5 << col_array[col][row]
                elsif col < 9 && row < 6
                  quad6 << col_array[col][row]   
                elsif col < 3 && row < 9
                  quad7 << col_array[col][row]
                elsif col < 6 && row < 9
                  quad8 << col_array[col][row]
                elsif col < 9 && row < 9
                  quad9 << col_array[col][row]
              end
          end
        end
      end
      f = val_list.flatten.find{|f| val_list.flatten.count(f) == 1 }
      tmp_list = []
      9.times do |row|
        if col_array[col][row] == 0
          insertion = false
          tmp_list = (1..9).select{|s| !puzzle[row].include?s}
          tmp_list = tmp_list.select{|s| !col_array[col].include?s}
          if col < 3 && row < 3
            tmp_list = tmp_list.select{|s| !(quad1.include?s)}
            elsif col < 6 && row < 3
              tmp_list = tmp_list.select{|s| !(quad2.include?s)}
            elsif col < 9 && row < 3
              tmp_list = tmp_list.select{|s| !(quad3.include?s)}
            elsif col < 3 && row < 6
              tmp_list = tmp_list.select{|s| !(quad4.include?s)}
            elsif col < 6 && row < 6
              tmp_list = tmp_list.select{|s| !(quad5.include?s)}
            elsif col < 9 && row < 6
              tmp_list = tmp_list.select{|s| !(quad6.include?s)}
            elsif col < 3 && row < 9
              tmp_list = tmp_list.select{|s| !(quad7.include?s)}
            elsif col < 6 && row < 9
              tmp_list = tmp_list.select{|s| !(quad8.include?s)}
            elsif col < 9 && row < 9
              tmp_list = tmp_list.select{|s| !(quad9.include?s)}
          end
          if tmp_list.include?f
            col_array[col][row] = puzzle[row][col] = f
          
            if col < 3 && row < 3
              quad1 << col_array[col][row]
              elsif col < 6 && row < 3
                quad2 << col_array[col][row]
              elsif col < 9 && row < 3
                quad3 << col_array[col][row]
              elsif col < 3 && row < 6
                quad4 << col_array[col][row]
              elsif col < 6 && row < 6
                quad5 << col_array[col][row]
              elsif col < 9 && row < 6
                quad6 << col_array[col][row]   
              elsif col < 3 && row < 9
                quad7 << col_array[col][row]
              elsif col < 6 && row < 9
                quad8 << col_array[col][row]
              elsif col < 9 && row < 9
                quad9 << col_array[col][row]
            end
            
          end
        end
      end
    end
    return puzzle if insertion == true
  end
end

puzzle = [
  [5,3,0,0,7,0,0,0,0],
  [6,0,0,1,9,5,0,0,0],
  [0,9,8,0,0,0,0,6,0],
  [8,0,0,0,6,0,0,0,3],
  [4,0,0,8,0,3,0,0,1],
  [7,0,0,0,2,0,0,0,6],
  [0,6,0,0,0,0,2,8,0],
  [0,0,0,4,1,9,0,0,5],
  [0,0,0,0,8,0,0,7,9]]

  solution = [
    [5,3,4,6,7,8,9,1,2],
    [6,7,2,1,9,5,3,4,8],
    [1,9,8,3,4,2,5,6,7],
    [8,5,9,7,6,1,4,2,3],
    [4,2,6,8,5,3,7,9,1],
    [7,1,3,9,2,4,8,5,6],
    [9,6,1,5,3,7,2,8,4],
    [2,8,7,4,1,9,6,3,5],
    [3,4,5,2,8,6,1,7,9]]
    

  p sudoku(puzzle)