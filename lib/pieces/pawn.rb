require_relative '../chess_module'
require 'pry-byebug'

class Pawn
  include Chess

  attr_reader :name, :colour, :code
  attr_accessor :position, :en_passant
  
  def initialize(colour, position, code)
    @name = ' pawn '
    @colour = colour
    @position = position
    @code = code
    @en_passant = false
  end

  def basic_moves
    if self.position[0] == 1 && self.colour == 'black' || self.position[0] == 6 && colour == 'white' 
      @colour == 'black' ? [[+1, 0], [+2, 0]]  : [[-1, 0], [-2, 0]]
    else
      @colour == 'black' ? [[+1, 0]] : [[ -1, 0]]
    end
  end

  def attack_moves(board)
    moves_arr = self.colour == 'black' ? [[+1, -1], [+1, +1]] : [[-1, -1], [-1, +1]]
    arr = []
    moves_arr.each do |item|
      temp_position = [self.position[0] + item[0], self.position[1] + item[1]]

      if on_board?(temp_position) == false || board[temp_position[0]][temp_position[1]].piece == nil
        next
      elsif board[temp_position[0]][temp_position[1]].piece.colour != self.colour
        arr << temp_position
      else
        next
      end
    end
    arr
  end

  def en_passant_attack(board)
    left = board[self.position[0]][self.position[1] - 1] if self.position[1] > 0
    right = board[self.position[0]][self.position[1] + 1] if self.position[1] < 7

    if self.colour == 'black'
      if left != nil && left.piece != nil && left.piece.name == ' pawn ' && left.piece.colour == 'white' && left.piece.en_passant == true
        return [self.position[0] + 1, self.position[1] - 1]
      elsif right != nil && right.piece != nil && right.piece.name == ' pawn ' && right.piece.colour == 'white' && right.piece.en_passant == true
        return [self.position[0] + 1, self.position[1] + 1]
      end
    else
      if left!= nil && left.piece != nil && left.piece.name == ' pawn ' && left.piece.colour == 'black' && left.piece.en_passant == true
        return [self.position[0] - 1, self.position[1] - 1]
      elsif right != nil && right.piece != nil && right.piece.name == ' pawn ' && right.piece.colour == 'black' && right.piece.en_passant == true
        return [self.position[0] - 1, self.position[1] + 1]
      end
    end
  end
  
  def potential_moves(board)
    basic_arr = basic_moves
    arr = []

    basic_arr.each do |item|
      temp_position = [self.position[0] + item[0], self.position[1] + item[1]]
      if on_board?(temp_position) == false || board[temp_position[0]][temp_position[1]].piece != nil
        break
      else
        arr << temp_position
      end
    end 

    attack_arr = attack_moves(board)
    attack_arr.each {|item| arr << item }
    passant = en_passant_attack(board)
    arr << passant if passant != nil

    arr
  end

end