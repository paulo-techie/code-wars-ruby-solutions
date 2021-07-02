def sudoku(puzzle)
  col_array = []
  quad_val = { 1 => [], 2 => [], 3 => [], 4 => [], 5 => [], 6 => [], 7 => [], 8 => [], 9 => [] }
  
  9.times do |row|   # new array with flipped columns and rows
    column = []
    9.times do |col|
      column << puzzle[col][row]
      quad(quad_val, puzzle, col, row)
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
          tmplist = quad(quad_val, puzzle, col, row, tmp_list)
          val_list << tmplist
          if tmplist.size == 1
              col_array[col][row] = puzzle[row][col] = tmplist[0]
              quad(quad_val, puzzle, col, row)
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
          tmplist = quad(quad_val, puzzle, col, row, tmp_list)
          if tmplist.include?f
            col_array[col][row] = puzzle[row][col] = f      
            quad(quad_val, puzzle, col, row)         
          end
        end
      end
    end
    return puzzle if insertion == true
  end

end

def quad(quad_val, puzzle, col, row, *tmp_list)
  q = 0
  [3,6,9].each do |r|
    [3,6,9].each do |c|
      q += 1
      if (row > (r-4)) && (row < r) && (col > (c-4)) && (col < c)
        return tmp_list[0].select{|s| !(quad_val[q].include?s)} if tmp_list[0]
        quad_val[q] << puzzle[row][col]
      end
    end
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