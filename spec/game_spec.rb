require_relative '../lib/node.rb'
require_relative '../lib/pieces/pawn'
require_relative '../lib/pieces/king'
require_relative '../lib/game'

describe Game do
  let(:user_1) { instance_double(User, name: 'Chet', colour: 'black') }
  let(:user_2) { instance_double(User, name: 'Fran', colour: 'white') }
  subject(:game) { described_class.new(user_1, user_2) }
  let(:own_colour) {instance_double(Pawn, colour: 'black', position: [1, 2])}
  let(:enermy_colour) {instance_double(Pawn, colour: 'white', position: [1, 4])}
  let(:own_king) { instance_double(King, colour: 'black', position: [0, 2])}
  let(:f) { instance_double(Node, colour: 'white', piece: own_colour)}
  let(:n) { instance_double(Node, colour: 'black', piece: enermy_colour)}
  let(:k) {instance_double(Node, colour: 'black', piece: own_king)}
  let(:e) {instance_double(Node, colour: 'white', piece: nil)}


  describe 'attack_checking?' do
    it 'king has empty spaces all around' do
      game.board.board = [[ e , e , k , e , e , e , e , e ],
                          [ e , e , n , e , e , e , e , e ],
                          [ e , e , e , e , e , e , e , e ],
                          [ e , e , e , e , e , e , e , e ],
                          [ e , e , e , e , e , e , e , e ],
                          [ e , e , e , e , e , e , e , e ],
                          [ e , e , e , e , e , e , e , e ],
                          [ e , e , e , e , e , e , e , e ]]
      expect(game.attack_checking?(k, n)).to eq(false)
    end

    
  end
end