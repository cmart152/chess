require_relative '../chess_module'
require 'pry-byebug'

class Queen
  
  include Chess
  
  attr_reader :name, :colour, :code
  attr_accessor :position

  def initialize(colour, position, code)
    @name = ' queen'
    @colour = colour
    @position = position
    @@basic_moves = [[+1, +1], [-1, +1], [-1, -1], [+1, -1], [0, -1], [0, +1], [+1, 0], [-1, 0]]
    @code = code
  end

  def potential_moves(board)
    arr = []

    @@basic_moves.each do |item|
      temp_position = [@position[0] + item [0], @position[1] + item[1]]
      
      until on_board?(temp_position) == false || board[temp_position[0]][temp_position[1]].piece != nil
        arr << temp_position
        temp_position = [temp_position[0] + item [0], temp_position[1] + item[1]]
      end

      if on_board?(temp_position) == false  || board[temp_position[0]][temp_position[1]].piece.colour == self.colour
      
      else
        arr << temp_position
      end
    end
    arr
  end
end