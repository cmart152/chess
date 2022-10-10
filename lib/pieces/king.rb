require_relative '../chess_module'
require 'pry-byebug'

class King

include Chess

  attr_reader :name, :colour, :code
  attr_accessor :position

  def initialize(colour, position, code)
    @name = ' king '
    @colour = colour
    @position = position
    @moves = [[+1, +1], [-1, +1], [-1, -1], [+1, -1], [0, -1], [0, +1], [+1, 0], [-1, 0]]
    @code = code
  end

  def potential_moves(board)
    arr = []

    @moves.each do |item|
      temp_position = [self.position[0] + item[0], self.position[1] + item[1]]
      if on_board?(temp_position) == false
        next
      elsif board[temp_position[0]][temp_position[1]].piece == nil || board[temp_position[0]][temp_position[1]].piece.colour != self.colour
        arr << temp_position
      else
        next
      end
    end
    arr
  end
end 