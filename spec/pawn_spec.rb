require_relative '../lib/pieces/queen.rb'
require_relative '../lib/node.rb'
require 'pry-byebug'


describe Pawn do
  describe 'potential_moves' do
    context 'pawn is black' do
      subject(:p) { described_class.new('black', [1, 4]) }
      let(:own_colour) {instance_double(described_class, colour: 'black', position: [1, 5])}
      let(:enermy_colour) {instance_double(described_class, colour: 'white', position: [6, 2])}
      let(:f) { instance_double(Node, colour: 'white', piece: own_colour)}
      let(:n) { instance_double(Node, colour: 'black', piece: enermy_colour)}
      let(:e) { instance_double(Node, colour: 'white', piece: nil)}

      it 'first turn there is 2 moves infront of pawn' do
        board =  [['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x', p ,'x','x','x'],
                  ['x','x','x', f , e , f ,'x','x'],
                  ['x','x','x','x', e ,'x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x']]
        expect(p.potential_moves(board)).to eq([[2,4], [3,4]])
      end
    
      it 'pawn is making second move with empty spaces infront' do
        p.position = [2,4]
        board =  [['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x', e ,'x','x','x'],
                  ['x','x','x', e , p , e ,'x','x'],
                  ['x','x','x', f , e , e ,'x','x'],
                  ['x','x','x','x', e ,'x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x']]
        expect(p.potential_moves(board)).to eq([[3,4]])
      end
    
      it 'pawn has piece directly infront' do
        p.position = [1,4]
        board =  [['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x', p ,'x','x','x'],
                  ['x','x','x', f , n , f ,'x','x'],
                  ['x','x','x','x', e ,'x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x']]
        expect(p.potential_moves(board)).to eq([])
      end

      it 'pawn has piece diagonally infront' do
        p.position = [1, 4]
        board =  [['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x', p ,'x','x','x'],
                  ['x','x','x', f , f , n ,'x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x']]
        expect(p.potential_moves(board)).to eq([[2,5]])
      end
    end

    context 'pawn is white' do
      subject(:p) { described_class.new('white', [6, 3]) }
      let(:own_colour) {instance_double(described_class, colour: 'white', position: [6, 5])}
      let(:enermy_colour) {instance_double(described_class, colour: 'black', position: [6, 2])}
      let(:f) { instance_double(Node, colour: 'white', piece: own_colour)}
      let(:n) { instance_double(Node, colour: 'black', piece: enermy_colour)}
      let(:e) { instance_double(Node, colour: 'white', piece: nil)}

      it 'first turn there is 2 moves infront of pawn' do
        board =  [['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x', e ,'x','x','x','x'],
                  ['x','x', f , e , f ,'x','x','x'],
                  ['x','x','x', p ,'x','x','x','x'],
                  ['x','x','x','x','x','x','x','x']]
        expect(p.potential_moves(board)).to eq([[5,3], [4,3]])
      end
    
      it 'pawn is making second move with empty spaces infront' do
        p.position = [5,3]
        board =  [['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x', e ,'x','x','x','x'],
                  ['x','x', f , e , f ,'x','x','x'],
                  ['x','x','x', p ,'x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x']]
        expect(p.potential_moves(board)).to eq([[4,3]])
      end
    
      it 'pawn has piece directly infront' do
        p.position = [3,1]
        board =  [['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  [ f , n , f ,'x','x','x','x','x'],
                  ['x', p ,'x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x']]
        expect(p.potential_moves(board)).to eq([])
      end

      it 'pawn has piece diagonally infront' do
        p.position = [5, 1]
        board =  [['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  [ f , f , n ,'x','x','x','x','x'],
                  ['x', p ,'x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x']]
        expect(p.potential_moves(board)).to eq([[4, 2]])
      end
    end
  end
end