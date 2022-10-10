require_relative 'board'
require 'pry-byebug'

class Game < Board
  def initialize(user_1, user_2)
    @user_1 = user_1
    @user_2 = user_2
    @board = Board.new(@user_1, @user_2)
    @turn = 'black'
    @game_over = false
  end

  def begin
    board.display_board

    puts "\n\nTo play, enter the coordinates of a piece you would like to move, followed by the coordinates
    of a space you would like to move to

    Example: 'A2A4' would move the bottom left pawn up 2 squares

    Press enter to start the game"
    gets
    game_loop
  end

  def game_loop
    until @game_over == true
      @turn == 'black' ? @turn = 'white' : @turn = 'black'
      user_turn
      system("clear")
      board.display_board
    end

    end_games
  end

  def end_games
    if @turn == 'white'
      if check_mate?('black')
        puts "Check mate, #{@user_1.name} wins!"
      elsif stale_mate?('black')
        puts "Stale mate, the game is a draw"
      end
    else 
      if check_mate?('white')
        puts "Check mate, #{@user_2.name} wins!"
      elsif stale_mate?('white')
        puts "Stale mate, the game is a draw"
      end
    end
  end

  def user_turn
    if @turn == 'white'
      puts "it's #{@user_1.name}'s turn" 
    else
      puts "it's #{@user_2.name}'s turn"
    end

    user_move

    if @turn == 'white'
      @game_over = true if check_mate?('black') || stale_mate?('black')
      
    else 
      @game_over = true if check_mate?('white') || stale_mate?('white')
    end
  end

  def user_move
    clear_own_en_passant
    puts "You are in check" if check?(@turn)
    move = get_move
    check_en_passant_activate(move) if @board.board[move[0]][move[1]].piece.name == ' pawn '
    check_en_passant_attack(move) if move[1] < move[3] && @board.board[move[0]][move[1]].piece.name == ' pawn ' || move[1] > move[3] && @board.board[move[0]][move[1]].piece.name == ' pawn '
    @board.move_piece([move[0],move[1]], [move[2],move[3]])
    @board.promote_pawn([move[2], move[3]], @turn) if @board.board[move[2]][move[3]].piece.name == ' pawn ' && move[2] == 7 || @board.board[move[2]][move[3]].piece.name == ' pawn ' && move[2] == 0
  end

  def get_move
    input = translate_input(correct_format(gets.chomp.upcase))

    until contains_piece?(input) && correct_colour?(input) && legal_move?(input, @turn)
      if contains_piece?(input) == false
        puts "There is no piece in the square you selected"
        input = translate_input(correct_format(gets.chomp.upcase))
      elsif correct_colour?(input) == false
        puts "The piece you selected is not the correct colour"
        input = translate_input(correct_format(gets.chomp.upcase))
      else
        puts "The move you are making is not allowed"
        input = translate_input(correct_format(gets.chomp.upcase))
      end
    end
    input
  end

  def correct_format(input)
    until input.match?(/[A-H][1-8][A-H][1-8]/) && input.length == 4
      puts "That input is not on the board, try again. e.g \"A2A3\""
      input = gets.chomp.upcase
    end
    input
  end

  def translate_input(input)
    arr = input.split('')
    arr.map! do |character| 
      case character
      when 'A', '8'
        character = 0
      when 'B', '7'
        character = 1
      when 'C', '6' 
        character = 2
      when 'D', '5'
        character = 3
      when 'E', '4'
        character = 4
      when 'F', "3"
        character = 5
      when 'G', '2'
        character = 6
      when 'H', '1'
        character = 7
      end
    end
    arr = [arr[1], arr[0], arr[3], arr[2]]
  end

  def legal_move?(input, colour)
    reference_to_piece = nil
    if @board.board[input[0]][input[1]].piece.potential_moves(@board.board).include?([input[2], input[3]]) 
      reference_to_piece = @board.board[input[2]][input[3]].piece if @board.board[input[2]][input[3]].piece != nil
      @board.move_piece([input[0], input[1]], [input[2], input[3]])
      check?(colour) ? result = false : result = true
      @board.move_piece([input[2], input[3]], [input[0], input[1]])
      @board.board[input[2]][input[3]].piece = reference_to_piece
    end
    result 
  end


  def check_en_passant_activate(move)
    if move[0] - move[2] == 2 || move[0] - move[2] == -2 && @board.board[move[0]][move[1]].piece.name == ' pawn '
      @board.board[move[0]][move[1]].piece.en_passant = true
    end
  end

  def check_en_passant_attack(move)
    binding.pry
    if @turn == 'black'
      if move[1] > move[3]
        @board.board[move[0]][move[1] - 1].piece = nil
      elsif move[1] < move[3]
        @board.board[move[0]][move[1] + 1].piece = nil
      end
    else
      if move[1] > move[3]
        @board.board[move[0]][move[1] - 1].piece = nil
      elsif move[1] < move[3]
        @board.board[move[0]][move[1] + 1].piece = nil
      end
    end
  end

  def clear_own_en_passant
    arr = @turn == 'black' ? black_piece_arr : white_piece_arr

    arr.each {|piece| piece.en_passant = false if piece.name == ' pawn '}
  end

  def contains_piece?(input)
    @board.board[input[0]][input[1]].piece != nil ? true : false
  end

  def correct_colour?(input)
    @board.board[input[0]][input[1]].piece.colour == @turn ? true : false
  end 


  def see_position?(position, colour)
    colour == 'black' ? arr = white_piece_arr : arr = black_piece_arr

    arr.each do |piece| 
      return true if piece.potential_moves(@board.board).include?(position)
    end

    false
  end

  def find_king(colour)
    arr = colour == 'black' ? black_piece_arr : white_piece_arr

    arr.each {|piece| return piece if piece.name == ' king ' }
  end

  def check?(colour)
    king = find_king(colour)
    see_position?(king.position, colour) ? true : false
  end

  def check_mate?(colour)
    king = find_king(colour)
    return false if check?(colour) != true
    colour == 'white' ? arr = white_piece_arr : arr = black_piece_arr

    arr.each do |piece|
      piece.potential_moves(@board.board).each { |move| return false if legal_move?([piece.position[0], piece.position[1], move[0], move[1]], colour) }
    end
    true
  end

  def stale_mate?(colour)
    colour == 'white' ? arr = white_piece_arr : arr = black_piece_arr
    
    arr.each do |piece|
      piece.potential_moves(@board.board).each { |move| return false if legal_move?([piece.position[0], piece.position[1], move[0], move[1]], colour) }
    end
    true
  end

  def black_piece_arr
    arr = []
    @board.board.each do |row|
      row.each {|node| arr << node.piece if node.piece != nil && node.piece.colour == 'black'}
    end
    arr
  end

  def white_piece_arr
    arr = []
    @board.board.each do |row|
      row.each {|node| arr << node.piece if node.piece != nil && node.piece.colour == 'white'}
    end
    arr
  end
end