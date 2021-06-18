# Write a method that takes a field for well-known board game "Battleship" as an argument and returns true if it has a valid disposition of ships, false otherwise. Argument is guaranteed to be 10*10 two-dimension array. Elements in the array are numbers, 0 if the cell is free and 1 if occupied by ship.

# Battleship (also Battleships or Sea Battle) is a guessing game for two players. Each player has a 10x10 grid containing several "ships" and objective is to destroy enemy's forces by targetting individual cells on his field. The ship occupies one or more cells in the grid. Size and number of ships may differ from version to version. In this kata we will use Soviet/Russian version of the game.


# Before the game begins, players set up the board and place the ships accordingly to the following rules:
# There must be single battleship (size of 4 cells), 2 cruisers (size 3), 3 destroyers (size 2) and 4 submarines (size 1). Any additional ships are not allowed, as well as missing ships.
# Each ship must be a straight line, except for submarines, which are just single cell.

# The ship cannot overlap or be in contact with any other ship, neither by edge nor by corner.

# This is all you need to solve this kata. If you're interested in more information about the game, visit this link: https://en.wikipedia.org/wiki/Battleship_(game)

def validate_battlefield(field)
  ship_width = 4
  cruiser_width = 3
  destroyer_width = 2
  sub_width = 1
  horizontal = true
  ship, cruiser, destroyer, sub = 0,0,0,0;
  flat = field.flatten.map.to_a
  flat.each_with_index do |a,i|
    if i%10 < 7 && i < 97 && 1 == flat[i] \
      && flat[i] == flat[i+1] \
      && flat[i+1] == flat[i+2] \
      && flat[i+2] == flat[i+3]
      return false if touched_edge(ship_width, horizontal, i, flat)
      return false if i < 87 && \
        flat[i+10] + flat[i+11] + flat[i+12] + flat[i+13] > 0
      ship += 1
      flat[i] = flat[i+1] = flat[i+2] = flat[i+3] = 0
    elsif i < 70 && 1 == flat[i] \
      && flat[i] == flat[i+10] \
      && flat[i+10] == flat[i+20] \
      && flat[i+20] == flat[i+30]
      return false if i%10 == 8 && \
        flat[i+1] + flat[i+11] + flat[i+21] +flat[i+31] > 0
      ship += 1
      flat[i] = flat[i+10] = flat[i+20] = flat[i+30] = 0
    elsif i%10 < 8 && i < 98 && 1 == flat[i] \
      && flat[i] == flat[i+1] \
      && flat[i+1] == flat[i+2]
      return false if touched_edge(cruiser_width, horizontal, i, flat)
      return false if i < 88 && \
      flat[i+10] + flat[i+11] + flat[i+12] > 0
      cruiser += 1
      flat[i] = flat[i+1] = flat[i+2] = 0
    elsif i < 80 && 1 == flat[i] \
      && flat[i] == flat[i+10] \
      && flat[i+10] == flat[i+20]
      return false if i%10 == 8 && \
        flat[i+1] + flat[i+11] + flat[i+21] > 0
      cruiser += 1
      flat[i] = flat[i+10] = flat[i+20] = 0
    elsif i%10 < 9 && i < 99 && 1 == flat[i] \
      && flat[i] == flat[i+1]
      return false if touched_edge(destroyer_width, horizontal, i, flat)
      return false if i < 89 && \
      flat[i+10] + flat[i+11] > 0
      destroyer += 1
      flat[i] = flat[i+1] = 0
    elsif i < 90 && 1 == flat[i] \
      && flat[i] == flat[i+10]
      return false if i%10 == 8 && \
        flat[i+1] + flat[i+11] > 0
      destroyer += 1
      flat[i] = flat[i+10] = 0
    elsif 1 == flat[i]
      return false if touched_edge(sub_width, horizontal, i, flat)
      sub += 1
      
      flat[i] = 0
    end
  end
  return false if ship > 1 || cruiser > 2 || destroyer > 3 || sub > 4 || \
                  ship < 1 || cruiser < 2 || destroyer < 3 || sub < 4
  true
end

def touched_edge(width, horizontal, i, flat)
  if width == 4 # ship
    if horizontal
      if i%10>0 && i%10<6
        return true if flat[i+9] == 1 || flat[i+14] == 1 && i+14<100
      end
    end
  end
  if width == 3 # ship
    if horizontal
      if i%10>0 && i%10<7
        return true if flat[i+9] == 1 || flat[i+13] == 1 && i+13<100
      end
    end
  end
  if width == 2 # ship
    if horizontal
      if i%10>0 && i%10<8
        return true if flat[i+9] == 1 || flat[i+12] == 1 && i+12<100
      end
    end
  end
  if width == 1 # ship
    if horizontal
      if i%10>0 && i%10<9
        return true if flat[i+9] == 1 || flat[i+11] == 1 && i+14<100
      end
    end
  end
end


# Test - should return true:

field = [[1, 0, 0, 0, 0, 1, 1, 0, 0, 0],
[1, 0, 1, 0, 0, 0, 0, 0, 1, 0],
[1, 0, 1, 0, 1, 1, 1, 0, 1, 0],
[1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
[0, 0, 0, 0, 1, 1, 1, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
[0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]

puts validate_battlefield(field)


# # More tests

# def judge(testfield, expected)
#   puts testfield.map(&:to_s).join("\n")
#   actual   = validate_battlefield(testfield)
#   Test.assert_equals(actual, expected)
#   Test.expect(false, "cheater...") if actual==true && actual==false
# end


# describe "Fixed tests" do
#   it("Must return true for valid field") do
#   field = [[1, 0, 0, 0, 0, 1, 1, 0, 0, 0],
#            [1, 0, 1, 0, 0, 0, 0, 0, 1, 0],
#            [1, 0, 1, 0, 1, 1, 1, 0, 1, 0],
#            [1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
#            [0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
#            [0, 0, 0, 0, 1, 1, 1, 0, 0, 0],
#            [0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
#            [0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
#            [0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
#            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]
#   judge(field, true)
#   end
  
#   it("Must return false if unwanted ships are present") do
#   field = [[1, 0, 0, 0, 0, 1, 1, 0, 0, 0],
#            [1, 0, 1, 0, 0, 0, 0, 0, 1, 0],
#            [1, 0, 1, 0, 1, 1, 1, 0, 1, 0],
#            [1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
#            [0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
#            [0, 0, 0, 0, 1, 1, 1, 0, 0, 0],
#            [0, 1, 0, 0, 0, 0, 0, 0, 1, 0],
#            [0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
#            [0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
#            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]
#   judge(field, false)
#   end
  
#   it("Must return false if number of ships of some type is incorrect") do
#   field = [[1, 0, 0, 0, 0, 1, 1, 0, 0, 0],
#            [1, 0, 1, 0, 0, 0, 0, 0, 1, 0],
#            [1, 0, 1, 0, 1, 1, 1, 0, 1, 0],
#            [1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
#            [0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
#            [0, 0, 0, 1, 1, 1, 1, 0, 0, 0],
#            [0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
#            [0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
#            [0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
#            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]
#   judge(field, false)
#   end
  
#   it("Must return false if some of ships is missing") do
#   field = [[0, 0, 0, 0, 0, 1, 1, 0, 0, 0],
#            [0, 0, 1, 0, 0, 0, 0, 0, 1, 0],
#            [0, 0, 1, 0, 1, 1, 1, 0, 1, 0],
#            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
#            [0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
#            [0, 0, 0, 0, 1, 1, 1, 0, 0, 0],
#            [0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
#            [0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
#            [0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
#            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]
#   judge(field, false)
#   end
  
#   it("Must return false if ships are in contact") do
#   field = [[1, 0, 0, 0, 0, 1, 1, 0, 0, 0],
#            [1, 0, 1, 0, 0, 0, 0, 0, 1, 0],
#            [1, 0, 1, 0, 1, 1, 1, 0, 1, 0],
#            [1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
#            [0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
#            [0, 0, 0, 0, 1, 1, 1, 0, 0, 0],
#            [0, 0, 0, 1, 0, 0, 0, 0, 1, 0],
#            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
#            [0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
#            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]
#   judge(field, false)
#   end
  
#   it("Must return false if some of ships has incorrect shape (non-straight)") do
#   field = [[1, 0, 0, 0, 0, 1, 1, 0, 0, 0],
#            [1, 0, 0, 0, 0, 0, 0, 0, 1, 0],
#            [1, 1, 0, 0, 1, 1, 1, 0, 1, 0],
#            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
#            [0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
#            [0, 0, 0, 0, 1, 1, 1, 0, 0, 0],
#            [0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
#            [0, 1, 0, 1, 0, 0, 0, 0, 0, 0],
#            [0, 1, 0, 0, 0, 0, 0, 1, 0, 0],
#            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]
#   judge(field, false)
#   end
       
#   it("Must return false if the number and length of ships is not ok") do
#   field = [[1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
#            [1, 0, 1, 0, 0, 0, 0, 0, 1, 0],
#            [1, 0, 1, 0, 1, 1, 1, 0, 1, 0],
#            [1, 0, 1, 0, 0, 0, 0, 0, 0, 0],
#            [0, 0, 1, 0, 0, 0, 0, 0, 1, 0],
#            [0, 0, 0, 0, 1, 1, 1, 0, 0, 0],
#            [0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
#            [0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
#            [0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
#            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]
#   judge(field, false)
#   end
# end




# it "Random tests" do
  
#   def rndTests
      
#       @debug = false
      
#       def validator(field)
          
#           def flood(x, y)
#               while x<10 && @field[x][y] == 0 ; x,y = (10*x+y+1).divmod(10) end
              
#               return if x>9
              
#               bag, found = [[x,y]].to_set, Set.new
#               while !bag.empty?
#                   found |= bag
#                   bag.each{ |a,b| @field[a][b] = 0 }
                  
#                   bag = bag.each_with_object(Set.new){ |arr,baggy| 
#                             [[0,1], [0,-1], [1,0], [-1,0], [1,1], [-1,-1], [-1,1], [1,-1]].each{
#                                 |dx,dy| i,j = arr[0]+dx, arr[1]+dy
#                                         baggy << [i,j] if 0<=i && i<10 && 0<=j && j<10 && @field[i][j]==1 
#                             }
#                         }
#               end
#               valid = found.first.zip(*found).any?{ |axis| axis.to_set.size == 1 }
#               @cnts[valid ? found.size : -1] += 1
#               flood(x,y) if valid
#           end
          
#           return false if field.map(&:sum).sum != 20
          
#           puts "good so far!" if @debug
          
#           @cnts  = Hash.new{|h,k| h[k]=0}
#           @field = field.map(&:dup)
#           flood(0,0)
#           return @cnts == {4=>1, 3=>2, 2=>3, 1=>4}
#       end
      
      
      
#       def buildCase()
          
#           while true
#               field  = (1..10).map{|_| [0]*10 }
#               bboats = rand<0.75 ? [4, 3, 3, 2, 2, 2, 1, 1, 1, 1]
#                                  : (rand<0.5 ? rand(13) : 8+rand(5)).times.each_with_object([]){ |_,lst| lst << 1+rand(rand<0.9 ? 4:5) }
#               exclude = rand<0.5
#               checkLoop = 0
#               limitLoop = 100
#               puts "excluded=#{exclude}\n#{bboats.sum} boats : #{bboats}" if @debug
              
#               next if bboats.sum > 25 && exclude
              
#               bboats.sort!.reverse!.each{ |size|
#                   while true
#                       while true
#                           x,y = rand(10),rand(10)
#                           checkLoop += 1
#                           break if checkLoop >= limitLoop
#                           break if field[x][y]==0
#                       end
#                       checkLoop += 1
#                       break if checkLoop >= limitLoop
#                       dx,dy = [[0,1], [0,-1], [1,0], [-1,0]].sample
                      
#                       next if (0...size).any?{ |n| a,b = x+n*dx,y+n*dy ; a<0 || b<0 || a>9 || b>9 || field[a][b]!=0 }
                      
#                       (0...size).each{ |n| a,b = x+n*dx,y+n*dy ; field[a][b] = 1 }
                      
#                       if exclude
#                           moveX,moveY = dx==0 ? [(x-1..x+1),(y..y)] : [(x..x),(y-1..y+1)]
#                           moveX.each{ |xx| moveY.each{ |yy|
#                               (-1...size+1).each{ |n|
#                                   a,b = xx+n*dx, yy+n*dy
#                                   next if a<0 || b<0 || a>9 || b>9 || field[a][b]!=0
#                                   field[a][b] = 2
#                               }
#                             }
#                           }
#                       end
#                       break
#                   end
#               }
#               next if checkLoop >= limitLoop
              
#               field.each{ |r| r.each_with_index{|v,i| r[i] = 0 if v==2 }}
#               return field
#           end
#       end
      
      
      
#       valids, nTests = 0, 200
#       nTests.times do
#           testfield = buildCase()
          
#           puts testfield.map(&:to_s).join("\n") if @debug && false
          
#           expected = validator(testfield)
#           actual   = validate_battlefield(testfield)
#           valids += expected ? 1:0
#           Test.assert_equals(actual, expected)
#           Test.expect(false, "cheater...") if actual==true && actual==false
#       end
      
#       puts "#{valids}/#{nTests} valid" if @debug
#   end
#   rndTests
# end