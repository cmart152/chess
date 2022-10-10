require_relative '../lib/pieces/bishop.rb'
require_relative '../lib/node.rb'
require 'pry-byebug'


describe Bishop do

  subject(:b) { described_class.new('black', [1, 4]) }
  let(:own_colour) {instance_double(described_class, colour: 'black', position: [2, 2])}
  let(:enermy_colour) {instance_double(described_class, colour: 'white', position: [6, 2])}
  let(:f) { instance_double(Node, colour: 'white', piece: own_colour)}
  let(:n) { instance_double(Node, colour: 'black', piece: enermy_colour)}
  let(:e) { instance_double(Node, colour: 'white', piece: nil)}

  describe 'potential_moves' do
    it 'bishop(b) has no moves around' do
      board =  [['x','x','x', f , f , f ,'x','x'],
                ['x','x','x', f , b , f ,'x','x'],
                ['x','x','x', f , f , f ,'x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x']]
      expect(b.potential_moves(board)).to eq([])
    end

    it 'bishop(b) has 1 space(e)' do
      board =  [['x','x','x', f , f , f ,'x','x'],
                ['x','x','x', f , b , f ,'x','x'],
                ['x','x','x', f , f , e ,'x','x'],
                ['x','x','x','x','x','x', f ,'x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x']]
      expect(b.potential_moves(board)).to eq([[2,5]])
    end

    it 'bishop(b) has moves to end of board' do
      board =  [['x','x','x', f , f , f ,'x','x'],
                ['x','x','x', f , b , f ,'x','x'],
                ['x','x','x', e , f , f ,'x','x'],
                ['x','x', e ,'x','x','x','x','x'],
                ['x', e ,'x','x','x','x','x','x'],
                [ e ,'x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x']]
      expect(b.potential_moves(board)).to eq([[2,3], [3,2], [4,1], [5,0]])
    end

    it 'bishop(b) has 3 moves including taking an emeny(n)' do
      board =  [['x','x','x', f , f , f ,'x','x'],
                ['x','x','x', f , b , f ,'x','x'],
                ['x','x','x', f , f , e ,'x','x'],
                ['x','x','x','x','x','x', e ,'x'],
                ['x','x','x','x','x','x','x', n ],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x']]
      expect(b.potential_moves(board)).to eq([[2,5], [3,6], [4,7]])
    end
  end
end