# Should make a 7x6 board
# Placing peices should alternate red and yellow
# When we pick a column, it should fall to the bottom most available spot.
# Rules of winning:
#   check only valid diagonal directions for a continuous set of 4
#   horizontal in any direction by 4,
#   vertical in any direction by 4.
#
#   In any direction, we dont need to look at a specific marker,
#   we simply need to loop through all columns, all rows, and then
#   all eligible diagonals for a continuous set of 4.
# Should keep score from game to game (like galaca maybe?)
# Have a reset/start over button.
Shoes.app :width => 900, :height => 625 do
  grey = rgb(166,154,159)
  red = rgb(255,0,0)
  black = rgb(0,0,0)

  @board = []
  @columns = [[],[],[],[],[],[],[]]
  @picked = []
  @turn = 0

  6.times do |row|
    7.times do |column|
      r = rect 100 * column+5,
               100 * row+5, 100, 100, :fill => grey
      @board << r
      @columns[column] << row
    end
  end

  animate do
    button, x,y = self.mouse
    column = x / 100
    row = y / 100
    over_x = x % 100
    over_y = y % 100
    if button == 1
      if (5..105).include?(over_x)
        if (5..105).include?(over_y)
          @turn+=1 # or @turn = @turn + 1 ? whichever is easier to understand
          # Pick the bottom row for the column that was selected
          # is the tricky part. We need to select the space
          # that is within our same column, but at the bottom.
          # how do we do this?
          # needs to go to that columns lowest available spot
          #   save columns as arrays and push or pop like a stack.
          #color = rgb(rand(255), rand(255), rand(255))
          #
          #explain trinary operator? or do an if statement?
          # check to see if after you divide the number by 2 etc,
          # if that number eventually reaches 1, if it does, then its
          # an odd (first turn is a base case, because its 1) and we 
          # play red, else we play black
          color = @turn % 2 == 1 ? red : black
          #because of our column set of arrays,
          #we know we can take the last element there and multiply
          #it by the total number of rows to get it to the botom position.
          #We then have to offset where that bottom position is
          #based on current "column" from the mouse
          space = (@columns[column].last*7)+column
          @board[space].style(:fill => color)
          @picked << space
          @columns[column].pop
        end
      end
    else
      @board.each_with_index do |card, space|
        if !@picked.include?(space)
          card.style(:fill => blue)
        end
      end
    end
  end

end
