require_relative '../chess_module'

class Bishop

include Chess 

  attr_reader :name, :colour, :code
  attr_accessor :position

  def initialize(colour, position, code)
    @name = 'bishop'
    @colour = colour
    @position = position
    @moves = [[+1, +1], [-1, +1], [-1, -1], [+1, -1]]
    @code = code
  end

  def potential_moves(board)
    arr = []

    @moves.each do |item|
      temp_position = [self.position[0] + item[0], self.position[1] + item[1]]

      until on_board?(temp_position) == false || board[temp_position[0]][temp_position[1]].piece != nil
        arr << temp_position
        temp_position = [temp_position[0] + item[0], temp_position[1] + item[1]]
      end

      if on_board?(temp_position) == true
        arr << temp_position if board[temp_position[0]][temp_position[1]].piece.colour != self.colour
      end
    end
    arr
  end
end