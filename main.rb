require_relative 'lib/user.rb'
require_relative 'lib/game.rb'


puts "Welcome to chess
  what is the name of player 1 (white)?"

input_1 = gets.chomp

puts "What is the name of player 2 (black)?"

input_2 = gets.chomp

user_1 = User.new(input_1, 'white')
user_2 = User.new(input_2, 'black')

game = Game.new(user_1, user_2)


game.begin