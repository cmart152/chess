require_relative 'node'
require_relative 'pieces/rook'
require_relative 'pieces/pawn'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/queen'
require_relative 'user'
require 'pry-byebug'

class Board
  attr_accessor :board

  def initialize(user_1, user_2)
    @user_1 = user_1
    @user_2 = user_2
    @board = new_board
    populate_board   
  end

  def display_board
    system("clear")
    temp_arr = []
    num = 8
    puts "                                      #{@user_2.name} (black) \n\n\n" 
    puts "        A       B       C       D       E       F        G      H \n\n"
    @board.each do |arr|
      arr.each do|item|
        if item.piece != nil
          temp_arr << item.piece.code 
        else
          temp_arr << '     '
        end
      end

      puts "#{num}    #{temp_arr.join(' | ')}   #{num}
    ----------------------------------------------------------------"
    num -= 1
    temp_arr = []
    end
    puts "\n       A       B       C       D       E       F        G      H"
    puts "\n\n                                  #{@user_1.name} (white)"
  end

  def move_piece(current, next_space)
    board[next_space[0]][next_space[1]].piece = board[current[0]][current[1]].piece
    board[next_space[0]][next_space[1]].piece.position = next_space
    board[current[0]][current[1]].piece = nil
  end

  def promote_pawn(position, colour)
    puts 'What would you like to replace your pawn with?
    Q = queen
    B = bishop
    K = knight
    R - rook'

    input = verify_pawn_upgrade(gets.chomp.upcase)
    colour == 'white' ? swap_white_pawn(input, position) : swap_black_pawn(input, position)
  end

  private

  def swap_white_pawn(input, position)
    case input
    when input = 'Q'
      board[position[0]][position[1]].piece = Queen.new('white', position, "  \u265b  ")
    when input = 'B'
      board[position[0]][position[1]].piece = Bishop.new('white', position, "  \u265d  ")
    when input = 'K'
      board[position[0]][position[1]].piece = Knight.new('white', position, "  \u265e  ")
    when input = 'R'
      board[position[0]][position[1]].piece = Rook.new('white', position, "  \u265c  ")
    end
  end

  def swap_black_pawn(input, position)
    case input
    when input = 'Q'
      board[position[0]][position[1]].piece = Queen.new('black', position, "  \u2655  ")
    when input = 'B'
      board[position[0]][position[1]].piece = Bishop.new('black', position, "  \u2657  ")
    when input = 'K'
      board[position[0]][position[1]].piece = Knight.new('black', position, "  \u2658  ")
    when input = 'R'
      board[position[0]][position[1]].piece = Rook.new('black', position, "  \u2656  ")
    end
  end

  def verify_pawn_upgrade(input)
    until input.match?(/[QBKR]/)
      puts 'Enter either Q B K or R'
      input = gets.chomp.upcase
    end
  input
  end

  def new_board
    count = 1 
    arr = Array.new(8) { Array.new(8) }
    
    arr.each do |arr|
      count += 1
      arr.map! do |item|
        count += 1 
        count.even? ? item = Node.new('white') : item = Node.new('black')
      end
    end
  end

  def populate_board
    @board[0][0].piece = Rook.new('black', [0,0], "  \u2656  ")
    @board[0][1].piece = Knight.new('black', [0,1], "  \u2658  ")
    @board[0][2].piece = Bishop.new('black', [0,2], "  \u2657  ")
    @board[0][4].piece = King.new('black', [0,4], "  \u2654  ")
    @board[0][3].piece = Queen.new('black', [0,3], "  \u2655  ")
    @board[0][5].piece = Bishop.new('black', [0,5], "  \u2657  ")
    @board[0][6].piece = Knight.new('black', [0,6],  "  \u2658  ")
    @board[0][7].piece = Rook.new('black', [0,7], "  \u2656  ")

    @board[7][0].piece = Rook.new('white', [7,0], "  \u265c  ")
    @board[7][1].piece = Knight.new('white', [7,1], "  \u265e  ")
    @board[7][2].piece = Bishop.new('white', [7,2], "  \u265d  ")
    @board[7][4].piece = King.new('white', [7,4], "  \u265a  ")
    @board[7][3].piece = Queen.new('white', [7,3], "  \u265b  ")
    @board[7][5].piece = Bishop.new('white', [7,5], "  \u265d  ")
    @board[7][6].piece = Knight.new('white', [7,6], "  \u265e  ")
    @board[7][7].piece = Rook.new('white',  [7,7], "  \u265c  ")

    count = 0
    
    @board[1].each do |item| 
      item.piece = Pawn.new('black', [1, count], "  \u2659  ") 
      count += 1
    end

    count = 0

    @board[6].each do |item| 
      item.piece = Pawn.new('white', [6, count], "  \u265f  ") 
      count += 1
    end
  end 

end
