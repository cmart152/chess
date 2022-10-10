require_relative '../lib/pieces/rook.rb'
require_relative '../lib/node.rb'
require 'pry-byebug'


describe Rook do

  subject(:r) { described_class.new('black', [1, 4]) }
  let(:own_colour) {instance_double(described_class, colour: 'black', position: [2, 2])}
  let(:enermy_colour) {instance_double(described_class, colour: 'white', position: [6, 2])}
  let(:f) { instance_double(Node, colour: 'white', piece: own_colour)}
  let(:n) { instance_double(Node, colour: 'black', piece: enermy_colour)}
  let(:e) { instance_double(Node, colour: 'white', piece: nil)}

  describe 'potential_moves' do
    it 'rook(r) has no moves around' do
      board =  [['x','x','x', f , f , f ,'x','x'],
                ['x','x','x', f , r , f ,'x','x'],
                ['x','x','x', f , f , f ,'x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x']]
      expect(r.potential_moves(board)).to eq([])
    end

    it 'rook(r) has 4 moves infront' do
      board =  [['x','x','x', f , f , f ,'x','x'],
                ['x','x','x', f , r , f ,'x','x'],
                ['x','x','x', f , e , f ,'x','x'],
                ['x','x','x','x', e ,'x','x','x'],
                ['x','x','x','x', e ,'x','x','x'],
                ['x','x','x','x', e ,'x','x','x'],
                ['x','x','x','x', f ,'x','x','x'],
                ['x','x','x','x','x','x','x','x']]
      expect(r.potential_moves(board)).to eq([[2,4], [3,4], [4,4], [5,4]])
    end

    it 'rook(r) has 5 moves infront including taking an enemy at the end' do
      board =  [['x','x','x', f , f , f ,'x','x'],
                ['x','x','x', f , r , f ,'x','x'],
                ['x','x','x', f , e , f ,'x','x'],
                ['x','x','x','x', e ,'x','x','x'],
                ['x','x','x','x', e ,'x','x','x'],
                ['x','x','x','x', e ,'x','x','x'],
                ['x','x','x','x', n ,'x','x','x'],
                ['x','x','x','x','x','x','x','x']]
      expect(r.potential_moves(board)).to eq([[2,4], [3,4], [4,4], [5,4], [6,4]])
    end

    it 'rook(r) has horizontal moves left and right' do
      board =  [['x','x','x', f , f , f ,'x','x'],
                ['x', f , e , e , r , e , n ,'x'],
                ['x','x','x', f , f , f ,'x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x']]
      expect(r.potential_moves(board)).to eq([[1,3], [1,2], [1,5], [1,6]])
    end

    it 'rook(r) has moves to end of board' do
      board =  [['x','x','x', f , f , f ,'x','x'],
                ['x','x','x', f , r , e , e , e ],
                ['x','x','x', f , f , f ,'x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x']]
      expect(r.potential_moves(board)).to eq([[1,5], [1,6], [1,7]])
    end
  end
end