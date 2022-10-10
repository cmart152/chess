require_relative '../lib/pieces/king.rb'
require_relative '../lib/node.rb'

describe King do
  describe 'potential_moves' do
    subject(:k) { described_class.new('black', [1, 4]) }
      let(:own_colour) {instance_double(described_class, colour: 'black', position: [1, 5])}
      let(:enermy_colour) {instance_double(described_class, colour: 'white', position: [6, 2])}
      let(:f) { instance_double(Node, colour: 'white', piece: own_colour)}
      let(:n) { instance_double(Node, colour: 'black', piece: enermy_colour)}
      let(:e) { instance_double(Node, colour: 'white', piece: nil)}

      it 'king(k) has empty spaces(e) all around, can move to any' do
        board =  [['x','x','x', e , e , e ,'x','x'],
                  ['x','x','x', e , k , e ,'x','x'],
                  ['x','x','x', e , e , e ,'x','x'],
                  ['x','x','x','x', e ,'x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x']]
        expect(k.potential_moves(board).length).to eq(8)
      end

      it 'king has empty spaces(e)/enemies(n) all around, can move to any' do
        board =  [['x','x','x', e , e , n ,'x','x'],
                  ['x','x','x', n , k , e ,'x','x'],
                  ['x','x','x', e , e , e ,'x','x'],
                  ['x','x','x','x', e ,'x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x']]
        expect(k.potential_moves(board).length).to eq(8)
      end

      it 'king has empty spaces(e) and friendlies(f) around, can make 4 possible moves' do
        board =  [['x','x','x', e , f , e ,'x','x'],
                  ['x','x','x', e , k , e ,'x','x'],
                  ['x','x','x', f , f , f ,'x','x'],
                  ['x','x','x','x', e ,'x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x'],
                  ['x','x','x','x','x','x','x','x']]
        expect(k.potential_moves(board).length).to eq(4)
      end
  end
end