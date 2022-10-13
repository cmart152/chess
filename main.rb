require_relative 'lib/user.rb'
require_relative 'lib/game.rb'
require_relative 'lib/chess_module'
include Chess

puts "Welcome to chess

  Would you like to start a new 2 player game (1) or load a saved game(2)?"

  game_start = gets.chomp

  until game_start == '1' || game_start == '2'
    puts "Enter 1 to start a new game or 2 to load a saved game"
    game_start = gets.chomp
  end

  

if game_start == '1'

  puts "what is the name of player 1 (white)?"

  input_1 = gets.chomp

  puts "What is the name of player 2 (black)?"

  input_2 = gets.chomp

  user_1 = User.new(input_1, 'white')
  user_2 = User.new(input_2, 'black')

  game = Game.new(user_1, user_2)


  game.begin
else
  puts "Choose a saved game listed below and press enter"

  arr = Dir.entries("saves").select { |f| File.file? File.join("saves", f)}
  arr.each_with_index { |item, index| arr[index] = item[0...-5]}
  puts arr

  file = File.read("saves/#{check_for_file(gets.chomp)}.yaml")
  hash = YAML.load(file)

  game = Game.new(hash[:user_1], hash[:user_2])
  game.board = hash[:board]
  game.turn = hash[:turn]
  game.game_over = hash[:game_over]
  game.board.display_board
  game.user_turn
  game.board.display_board
  game.game_loop  
end