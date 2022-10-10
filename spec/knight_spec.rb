require_relative '../lib/pieces/knight'
require_relative '../lib/node'

describe Knight do
  describe 'potential moves' do
    subject(:k) { described_class.new('black', [1, 4]) }
    let(:own_colour) {instance_double(described_class, colour: 'black', position: [1, 5])}
    let(:enermy_colour) {instance_double(described_class, colour: 'white', position: [6, 2])}
    let(:f) { instance_double(Node, colour: 'white', piece: own_colour)}
    let(:n) { instance_double(Node, colour: 'black', piece: enermy_colour)}
    let(:e) { instance_double(Node, colour: 'white', piece: nil)}

    it 'knight has 1 move' do
      board =  [['x','x', f ,'x','x','x', f ,'x'],
                ['x','x','x','x', k ,'x','x','x'],
                ['x','x', f ,'x','x','x', f ,'x'],
                ['x','x','x', f ,'x', e ,'x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x']]
      expect(k.potential_moves(board)).to eq([[3, 5]])
    end

    it 'knight has 3 move' do
      board =  [['x','x', f ,'x','x','x', e ,'x'],
                ['x','x','x','x', k ,'x','x','x'],
                ['x','x', f ,'x','x','x', f ,'x'],
                ['x','x','x', e ,'x', e ,'x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x']]
      expect(k.potential_moves(board)).to eq([[3, 5], [3, 3], [0, 6]])
    end

    it 'knight can jump over piece' do
      board =  [['x','x', f ,'x','x','x', f ,'x'],
                ['x','x','x','x', k ,'x','x','x'],
                ['x','x', f ,'x', n , n , f ,'x'],
                ['x','x','x', f ,'x', e ,'x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x']]
      expect(k.potential_moves(board)).to eq([[3, 5]])
    end

    it 'knight can capture enemy' do
      board =  [['x','x', f ,'x','x','x', f ,'x'],
                ['x','x','x','x', k ,'x','x','x'],
                ['x','x', f ,'x','x','x', f ,'x'],
                ['x','x','x', f ,'x', n ,'x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x'],
                ['x','x','x','x','x','x','x','x']]
      expect(k.potential_moves(board)).to eq([[3, 5]])
    end
  end
end