class Node
  attr_accessor :colour, :piece

  def initialize(colour, piece = nil)
    @colour = colour
    @piece = piece
  end
end