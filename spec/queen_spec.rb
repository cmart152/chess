require_relative '../lib/pieces/queen.rb'
require_relative '../lib/node.rb'
require 'pry-byebug'


describe Queen do

  subject(:q) { described_class.new('black', [1, 4]) }
  let(:own_colour) {instance_double(Pawn, colour: 'black', position: [2, 2])}
  let(:enermy_colour) {instance_double(Pawn, colour: 'white', position: [6, 2])}
  let(:f) { instance_double(Node, colour: 'white', piece: own_colour)}
  let(:n) { instance_double(Node, colour: 'black', piece: enermy_colour)}
  let(:e) { instance_double(Node, colour: 'white', piece: nil)}

  describe 'potential_moves' do
    it 'queen had no spaces around' do
      board =  [['x','x','x', f , f , f ,'x','x'],
                ['x','x','x', f , q , f ,'x','x'],
                ['x','x','x', f , f , f ,'x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x']]
      expect(q.potential_moves(board)).to eq([])
    end

    context 'queen has vertical moves' do
      subject(:q) { described_class.new('black', [6, 3]) }
      it 'queen has 3 spaces above' do
        board =  [['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x', n ,'x','x','x','x'],
                  ['x','x', f , e , f ,'x','x','x'],
                  ['x','x', f , e , f ,'x','x','x'],
                  ['x','x', f , q , f ,'x','x','x'],
                  ['x','x', f , f , f ,'x','x','x']]
        arr = q.potential_moves(board)
        expect(arr).to eq([[5,3],[4,3],[3,3]])
      end
    end

    context 'queen has vertical moves to top of board' do
      subject(:q) { described_class.new('black', [6, 3]) }
      it 'queen has 6 spaces above' do
        board =  [['x','x','x', e ,'x','x','x','x'],
                  ['x','x','x', e ,'x','x','x','x'],
                  ['x','x','x', e ,'x','x','x','x'],
                  ['x','x','x', e ,'x','x','x','x'],
                  ['x','x', f , e , f ,'x','x','x'],
                  ['x','x', f , e , f ,'x','x','x'],
                  ['x','x', f , q , f ,'x','x','x'],
                  ['x','x', f , f , f ,'x','x','x']]
        arr = q.potential_moves(board)
        expect(arr).to eq([[5,3], [4,3], [3,3], [2,3], [1,3], [0,3]])
      end
    end

    context 'queen has vertical moves to bottom of board' do
      subject(:q) { described_class.new('black', [6, 3]) }
      it 'queen has 6 spaces above' do
        board =  [['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x''x','x','x','x'],
                  ['x','x', f , f , f ,'x','x','x'],
                  ['x','x', f , f , f ,'x','x','x'],
                  ['x','x', f , q , f ,'x','x','x'],
                  ['x','x', f , e , f ,'x','x','x']]
        arr = q.potential_moves(board)
        expect(arr).to eq([[7,3]])
      end
    end

    context 'queen has diagonal moves' do
      subject(:q) { described_class.new('black', [3, 3]) }
      it 'queen has 5 spaces 2 in either direction diagonal left and right' do
        board =  [['x','x','x','x','x','x', f ,'x'],
                  ['x','x','x','x','x', e ,'x','x'],
                  ['x','x', f , f , e ,'x','x','x'],
                  ['x','x', f , q , f ,'x','x','x'],
                  ['x','x', e , f , f ,'x','x','x'],
                  ['x', e ,'x','x','x','x','x','x'],
                  [ f ,'x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x']]
        arr = q.potential_moves(board)
        expect(arr).to eq([[2,4],[1,5],[4,2],[5,1]])
      end
    end
  end
end